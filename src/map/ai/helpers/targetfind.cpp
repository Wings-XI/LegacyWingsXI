﻿/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "targetfind.h"

#include <math.h>
#include "../../entities/charentity.h"
#include "../../entities/mobentity.h"
#include "../../entities/fellowentity.h"
#include "../../entities/trustentity.h"
#include "../../packets/action.h"
#include "../../alliance.h"
#include "../../../common/mmo.h"
#include "../../../common/utils.h"
#include "../../utils/zoneutils.h"
#include "../../enmity_container.h"
#include "../../status_effect_container.h"

#include "../../packets/action.h"

CTargetFind::CTargetFind(CBattleEntity* PBattleEntity)
{
    m_PBattleEntity = PBattleEntity;

    reset();
}

void CTargetFind::reset()
{
    m_findType = FIND_NONE;
    m_targets.clear();
    m_conal = false;
    m_radius = 0.0f;
    m_zone = 0;
    m_findFlags = FINDFLAGS_NONE;

    m_APoint = nullptr;
    m_PRadiusAround = nullptr;
    m_PTarget = nullptr;
    m_PMasterTarget = nullptr;
}

void CTargetFind::findSingleTarget(CBattleEntity* PTarget, uint8 flags)
{
    m_findFlags = flags;
    m_zone = m_PBattleEntity->getZone();
    m_PTarget = nullptr;
    m_PRadiusAround = &PTarget->loc.p;

    addEntity(PTarget, false);
}

void CTargetFind::findWithinArea(CBattleEntity* PTarget, AOERADIUS radiusType, float radius, uint8 flags)
{
    TracyZoneScoped;
    m_findFlags = flags;
    m_radius = radius;
    m_zone = m_PBattleEntity->getZone();
    CZone* PZone = m_zone ? zoneutils::GetZone(m_zone) : nullptr;
    bool inDynamis = PZone && PZone->GetType() && PZone->GetType() == ZONETYPE_DYNAMIS;

    if (radiusType == AOERADIUS_ATTACKER){
        m_PRadiusAround = &m_PBattleEntity->loc.p;
    }
    else {
        // radius around target
        m_PRadiusAround = &PTarget->loc.p;
    }

    // get master to properly handle loops
    m_PMasterTarget = findMaster(PTarget);

    // if DI is targetting himself with an AoE mobskill, treat it as an aoe targetting a player so the animation goes off even if nobody is hit
    CMobEntity* PMob = static_cast<CMobEntity*>(m_PBattleEntity);
    bool isIxionSource = (PMob != nullptr && PMob->m_Pool == 915);
    bool ixionSelfTargetAOE = (radius > 0 && m_PMasterTarget == m_PBattleEntity && isIxionSource);

    // no not include pets if this AoE is a buff spell
    // this is a buff because i'm targetting my self
    bool withPet = PETS_CAN_AOE_BUFF || (m_findFlags & FINDFLAGS_PET) || (m_PMasterTarget->objtype != m_PBattleEntity->objtype);

    // always add original target first
    addEntity(PTarget, false); // pet will be added later

    m_PTarget = PTarget;
    isPlayer = checkIsPlayer(m_PBattleEntity);

    if (isPlayer)
    {
        // handle this as a player
        if (m_PMasterTarget->objtype == TYPE_PC)
        {
            // players will never need to add whole alliance
            m_findType = FIND_PLAYER_PLAYER;

            if (m_PMasterTarget->PParty != nullptr)
            {
                // player -ra spells should never hit whole alliance
                if ((m_findFlags & FINDFLAGS_ALLIANCE) && m_PMasterTarget->PParty->m_PAlliance != nullptr)
                {
                    addAllInAlliance(m_PMasterTarget, withPet);
                }
                else
                {
                    // add party members
                    addAllInParty(m_PMasterTarget, withPet);
                }
            }
            else 
            {
                // just add myself
                addEntity(m_PMasterTarget, withPet);

                // if i'm the target of my own aoe buff - add my fellow if they exist
                if (m_PMasterTarget == m_PBattleEntity && ((CCharEntity*)m_PMasterTarget)->m_PFellow != nullptr)
                    addEntity(((CCharEntity*)m_PMasterTarget)->m_PFellow, false);
            }
        }
        else 
        {
            m_findType = FIND_PLAYER_MONSTER;
            // special case to add all mobs in range
            addAllInMobList(m_PMasterTarget, false);
        }
    }
    else 
    {
        // handle this as a mob
        if (m_PMasterTarget->objtype == TYPE_PC || m_PBattleEntity->allegiance == ALLEGIANCE_PLAYER ||
            (ixionSelfTargetAOE == true)) // DI targetting himself with AoE mobskill
            {
                m_findType = FIND_MONSTER_PLAYER;
        }
        else {
            m_findType = FIND_MONSTER_MONSTER;
        }

        // do not include pets in monster AoE buffs
        if (m_findType == FIND_MONSTER_MONSTER && m_PTarget->PMaster == nullptr)
        {
            withPet = PETS_CAN_AOE_BUFF;
        }

        if (m_findFlags & FINDFLAGS_HIT_ALL ||
            (m_findType == FIND_MONSTER_PLAYER && (((CMobEntity*)m_PBattleEntity)->CalledForHelp() || inDynamis)) ||
            (ixionSelfTargetAOE == true))
        {
            addAllInZone(m_PMasterTarget, withPet);
        }
        else
        {
            addAllInAlliance(m_PMasterTarget, withPet);

            // Is the monster casting on a player..
            if (m_findType == FIND_MONSTER_PLAYER)
            {
                if (m_PBattleEntity->allegiance == ALLEGIANCE_PLAYER)
                    addAllInZone(m_PMasterTarget, withPet);
                else
                    addAllInEnmityList();
            }
        }
    }
}

void CTargetFind::findWithinCone(CBattleEntity* PTarget, AOERADIUS radiusType, float distance, float angle, uint8 flags, uint8 extraRotation)
{
    TracyZoneScoped;

    m_findFlags = flags;
    m_conal = true;

    m_APoint = &m_PBattleEntity->loc.p;
    //m_APoint->rotation += extraRotation; typically used for "aoe behind me" instead of "aoe in front of me" (an addition of 128) example: Behe's Kick Out - Disabled to prevent the mob from actually rotating.

    uint8 halfAngle = static_cast<uint8>((angle * (256.0f / 360.0f)) / 2.0f);

    uint8 angleToTarget = m_APoint->rotation + extraRotation;
    if (radiusType != AOERADIUS_ATTACKER && m_PBattleEntity != PTarget) { // failback to attacker's rotation (plus extraRotation) if self-targetting
        worldAngle(m_PBattleEntity->loc.p, PTarget->loc.p);  // always returns zero if attacker and target are the same
    }

    // "Left" and "Right" are like the entity's face - "left" means "turning to the left" NOT "left when looking overhead"
    // Remember that rotation increases when turning to the right, and decreases when turning to the left
    float leftAngle = rotationToRadian(relativeAngle(angleToTarget, -halfAngle));
    float rightAngle = rotationToRadian(relativeAngle(angleToTarget, halfAngle));

    // calculate end points for triangle
    m_BPoint.x = cosf((2 * (float)M_PI) - rightAngle) * distance + m_APoint->x;
    m_BPoint.z = sinf((2 * (float)M_PI) - rightAngle) * distance + m_APoint->z;

    m_CPoint.x = cosf((2 * (float)M_PI) - leftAngle) * distance + m_APoint->x;
    m_CPoint.z = sinf((2 * (float)M_PI) - leftAngle) * distance + m_APoint->z;

    // ShowDebug("angle %f, left %f, right %f, distance %f, A (%f, %f) B (%f, %f) C (%f, %f)\n", angle, leftAngle, rightAngle, distance, m_APoint->x, m_APoint->z, m_BPoint.x, m_BPoint.z, m_CPoint.x, m_CPoint.z);
    // ShowDebug("Target: (%f, %f)\n", PTarget->loc.p.x, PTarget->loc.p.z);

    // precompute for next stage
    m_BPoint.x = m_BPoint.x - m_APoint->x;
    m_BPoint.z = m_BPoint.z - m_APoint->z;

    m_CPoint.x = m_CPoint.x - m_APoint->x;
    m_CPoint.z = m_CPoint.z - m_APoint->z;

    // calculate scalar
    m_scalar = (m_BPoint.x * m_CPoint.z) - (m_BPoint.z * m_CPoint.x);

    findWithinArea(PTarget, AOERADIUS_ATTACKER, distance);
}

void CTargetFind::addAllInMobList(CBattleEntity* PTarget, bool withPet)
{
    CCharEntity* PChar = dynamic_cast<CCharEntity*>(findMaster(m_PBattleEntity));
    if (PChar)
    {
        for (SpawnIDList_t::const_iterator it = PChar->SpawnMOBList.begin(); it != PChar->SpawnMOBList.end(); ++it)
        {
            CBattleEntity* PBattleTarget = dynamic_cast<CBattleEntity*>(it->second);
            if (PBattleTarget && isMobOwner(PBattleTarget))
            {
                addEntity(PBattleTarget, withPet);
            }
        }
    }
}

void CTargetFind::addAllInZone(CBattleEntity* PTarget, bool withPet)
{
    TracyZoneScoped;
	zoneutils::GetZone(PTarget->getZone())->ForEachCharInstance(PTarget, [&](CCharEntity* PChar){
		if (PChar){
			addEntity(PChar, withPet);
		}
	});
	zoneutils::GetZone(PTarget->getZone())->ForEachMobInstance(PTarget, [&](CMobEntity* PMob){
		if (PMob){
			addEntity(PMob, withPet);
		}
	});
    zoneutils::GetZone(PTarget->getZone())->ForEachTrustInstance(PTarget, [&](CTrustEntity* PTrust){
		if (PTrust){
			addEntity(PTrust, withPet);
		}
	});
}

void CTargetFind::addAllInAlliance(CBattleEntity* PTarget, bool withPet)
{
    PTarget->ForAlliance([this, withPet](CBattleEntity* PMember)
    {
        addEntity(PMember, withPet);
    });
}

void CTargetFind::addAllInParty(CBattleEntity* PTarget, bool withPet)
{
    if (PTarget->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(PTarget)->ForPartyWithTrusts([this, withPet](CBattleEntity* PMember)
        {
            addEntity(PMember, withPet);
            // if the caster is in the same the party as the aoe target, and has a fellow - include the fellow in the buff
            // this covers AoEs orginated by the caster that target others (curaga, sch accession, divine veil)
            if (PMember == m_PBattleEntity && ((CCharEntity*)m_PBattleEntity)->m_PFellow != nullptr)
                addEntity(((CCharEntity*)m_PBattleEntity)->m_PFellow, false);
        });
    }
    else
    {
        PTarget->ForParty([this, withPet](CBattleEntity* PMember)
        {
            addEntity(PMember, withPet);
        });
    }
}

void CTargetFind::addAllInEnmityList()
{
    if (m_PBattleEntity->objtype == TYPE_MOB)
    {
        CMobEntity* mob = (CMobEntity*)m_PBattleEntity;
        EnmityList_t* enmityList = mob->PEnmityContainer->GetEnmityList();

        for (EnmityList_t::iterator it = enmityList->begin(); it != enmityList->end(); ++it)
        {
            EnmityObject_t& PEnmityObject = it->second;
            if (PEnmityObject.PEnmityOwner)
            {
                addEntity(PEnmityObject.PEnmityOwner, false);
            }
        }
    }
}

void CTargetFind::addAllInRange(CBattleEntity* PTarget, float radius, uint8 allegiance)
{
    TracyZoneScoped;

    m_radius = radius;
    m_PRadiusAround = &(m_PBattleEntity->loc.p);

    if (allegiance == ALLEGIANCE_PLAYER)
    {
        if (PTarget && PTarget->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PTarget);
            for (auto& list : { PChar->SpawnPCList, PChar->SpawnPETList })
            {
                for (auto& pair : list)
                {
                    CBattleEntity* PBattleEntity = static_cast<CBattleEntity*>(pair.second);
                    if (PBattleEntity &&
                        isWithinArea(&(PBattleEntity->loc.p)) &&
                        !PBattleEntity->isDead() &&
                        PBattleEntity->allegiance == ALLEGIANCE_PLAYER)
                    {
                        m_targets.push_back(PBattleEntity);
                    }
                }
            }
        }
        else
        {
            zoneutils::GetZone(PTarget->getZone())->ForEachCharInstance(PTarget, [&](CCharEntity* PChar)
            {
                if (PChar && isWithinArea(&(PChar->loc.p)) && !PChar->isDead())
                {
                    m_targets.push_back(PChar);
                }
            });
        }
    }
}

void CTargetFind::addEntity(CBattleEntity* PTarget, bool withPet)
{
    if (validEntity(PTarget)){
        m_targets.push_back(PTarget);
    }

    // add my pet too, if its allowed
    if (withPet && PTarget->PPet != nullptr && validEntity(PTarget->PPet))
    {
        m_targets.push_back(PTarget->PPet);
    }
}

// Given a CBattleEntitiy - returns the master of the CBattleEntity.  If no master is found, returns the CBattleEntity passed as a param
CBattleEntity* CTargetFind::findMaster(CBattleEntity* PTarget)
{
    if (PTarget->PMaster != nullptr){
        return PTarget->PMaster;
    }
    return PTarget;
}

bool CTargetFind::isMobOwner(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (findMaster(m_PBattleEntity)->objtype != TYPE_PC || findMaster(PTarget)->objtype == TYPE_PC)
    {
        // always true for mobs, npcs - not true for PCs or PC's pets
        return true;
    }

    if (PTarget->m_OwnerID.id == 0 || PTarget->m_OwnerID.id == m_PBattleEntity->id || PTarget->m_OwnerID.id == findMaster(m_PBattleEntity)->id)
    {
        return true;
    }

    bool found = false;

    findMaster(m_PBattleEntity)->ForAlliance([&found, &PTarget](CBattleEntity* PMember) {
        if (PMember->id == PTarget->m_OwnerID.id)
        {
            found = true;
        }
    });

    return found;
}

/*
validEntity will check if the given entity can be targeted in the AoE.

*/
bool CTargetFind::validEntity(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (std::find(m_targets.begin(), m_targets.end(), PTarget) != m_targets.end()) {
        return false;
    }
    if (!(m_findFlags & FINDFLAGS_DEAD) && PTarget->isDead())
    {
        return false;
    }

    if (m_PBattleEntity->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        m_PBattleEntity->PBattlefield != PTarget->PBattlefield || m_PBattleEntity->PInstance != PTarget->PInstance)
    {
        return false;
    }

    if (m_PTarget == PTarget || PTarget->getZone() != m_zone || PTarget->IsNameHidden() || PTarget->status == STATUS_INVISIBLE)
    {
        return false;
    }

    // this is first target, always add him first
    if (m_PTarget == nullptr)
    {
        return true;
    }

    CMobEntity* PMob = static_cast<CMobEntity*>(m_PBattleEntity);
    bool isIxionSource = (PMob != nullptr && PMob->m_Pool == 915); // Dark Ixion's AoEs target himself then select other entities based on positioning, require his targets to be player-aligned
	if ((m_PTarget->allegiance != PTarget->allegiance && !isIxionSource) || (isIxionSource && PTarget->allegiance != ALLEGIANCE_PLAYER))
	{
		return false;
	}

    // shouldn't add if target is charmed by the enemy
    if (PTarget->PMaster != nullptr)
    {
        if (m_findType == FIND_MONSTER_PLAYER){

            if (PTarget->PMaster->objtype == TYPE_MOB){
                return false;
            }

        }
        else if (m_findType == FIND_PLAYER_MONSTER){

            if (PTarget->PMaster->objtype == TYPE_PC){
                return false;
            }

        }
        else if (m_findType == FIND_MONSTER_MONSTER || m_findType == FIND_PLAYER_PLAYER){
            if (PTarget->objtype == TYPE_TRUST || PTarget->objtype == TYPE_FELLOW)
            {
                return true;
            }
            return false;
        }
    }

    // check placement
    // force first target to be added
    // this will be removed when conal targetting is polished
    if (m_conal)
    {
        if (isWithinCone(&PTarget->loc.p))
        {
            return true;
        }
    }
    else
    {
        if ((m_findFlags & FINDFLAGS_UNLIMITED) || isWithinArea(&PTarget->loc.p))
        {
            return true;
        }
    }

    return false;
}

bool CTargetFind::checkIsPlayer(CBattleEntity* PTarget)
{
    if (PTarget == nullptr) return false;
    if (PTarget->objtype == TYPE_PC) return true;

    // check if i'm owned by a pc
    return PTarget->PMaster != nullptr && PTarget->PMaster->objtype == TYPE_PC;
}

bool CTargetFind::isWithinArea(position_t* pos)
{
    return distance(*m_PRadiusAround, *pos) <= m_radius;
}

bool CTargetFind::isWithinCone(position_t* pos)
{
    TracyZoneScoped;
    position_t PPoint;

    // holds final weight
    position_t WPoint;

    // move origin to one vertex
    PPoint.x = pos->x - m_APoint->x;
    PPoint.z = pos->z - m_APoint->z;

    WPoint.x = (PPoint.x * (m_BPoint.z - m_CPoint.z) + PPoint.z * (m_CPoint.x - m_BPoint.x) + m_BPoint.x * m_CPoint.z - m_CPoint.x * m_BPoint.z) / m_scalar;

    WPoint.y = (PPoint.x * m_CPoint.z - PPoint.z * m_CPoint.x) / m_scalar;
    WPoint.z = (PPoint.z * m_BPoint.x - PPoint.x * m_BPoint.z) / m_scalar;

    // ShowDebug("A %f, B %f, C %f\n", WPoint.x, WPoint.y, WPoint.z);

    if (WPoint.x < 0 || WPoint.x > 1)
    {
        return false;
    }

    if (WPoint.y < 0 || WPoint.y > 1)
    {
        return false;
    }

    if (WPoint.z < 0 || WPoint.z > 1)
    {
        return false;
    }

    return true;
}

bool CTargetFind::isWithinRange(position_t* pos, float range)
{
    return distance(m_PBattleEntity->loc.p, *pos) <= range;
}


bool CTargetFind::canSee(position_t* point)
{
    //TODO: the detours raycast is not a line of sight raycast (it's a walkability raycast)
    //if (m_PBattleEntity->loc.zone && m_PBattleEntity->loc.zone->m_navMesh)
    //{
    //    position_t pA {0, m_PBattleEntity->loc.p.x, m_PBattleEntity->loc.p.y - 1, m_PBattleEntity->loc.p.z};
    //    position_t pB {0, point->x, point->y - 1, point->z};
    //    return m_PBattleEntity->loc.zone->m_navMesh->raycast(pA, pB);
    //}
    return true;
}

CBattleEntity* CTargetFind::getValidTarget(uint16 actionTargetID, uint16 validTargetFlags)
{
    TracyZoneScoped;
    CBattleEntity* PTarget = (CBattleEntity*)m_PBattleEntity->GetEntity(actionTargetID, TYPE_MOB | TYPE_PC | TYPE_PET | TYPE_TRUST | TYPE_FELLOW);

    if (PTarget == nullptr)
    {
        return nullptr;
    }

     if (m_PBattleEntity->objtype == TYPE_FELLOW)
    {
        CFellowEntity* PFellow = static_cast<CFellowEntity*>(m_PBattleEntity);

        if (PFellow->targid == actionTargetID)
        {
            return (CBattleEntity*)PFellow;
        }
    }

    if (m_PBattleEntity->objtype == TYPE_PC)
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(m_PBattleEntity);
        if (PChar->m_PFellow != nullptr && PChar->m_PFellow->targid == actionTargetID)
            return (CBattleEntity*)PChar->m_PFellow;
    }

    if (validTargetFlags & TARGET_PET)
    {
        return m_PBattleEntity->PPet;
    }

    if (PTarget->ValidTarget(m_PBattleEntity, validTargetFlags))
    {
        return PTarget;
    }

    return nullptr;
}
