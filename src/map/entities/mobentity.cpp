/*
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

#include "mobentity.h"

#include <string.h>
#include "../../common/timer.h"
#include "../../common/utils.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/controllers/player_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../ai/states/mobskill_state.h"
#include "../entities/charentity.h"
#include "../packets/action.h"
#include "../packets/entity_update.h"
#include "../packets/pet_sync.h"
#include "../utils/battleutils.h"
#include "../utils/blueutils.h"
#include "../utils/charutils.h"
#include "../utils/itemutils.h"
#include "../utils/mobutils.h"
#include "../utils/petutils.h"
#include "../utils/zoneutils.h"
#include "../dynamis_handler.h"
#include "../status_effect_container.h"
#include "../enmity_container.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../mob_modifier.h"
#include "../weapon_skill.h"
#include "../mobskill.h"
#include "../roe.h"
#include "../treasure_pool.h"
#include "../conquest_system.h"

int32 g_pixieAmity = 0;
time_t g_pixieLastAmityRefresh = 0;

CMobEntity::CMobEntity()
{
    objtype = TYPE_MOB;

    m_DropID = 0;

    m_minLevel = 1;
    m_maxLevel = 1;

    HPscale = 1.0;
    MPscale = 1.0;
    m_flags = 0;

    allegiance = ALLEGIANCE_MOB;

    // default to normal roaming
    m_roamFlags = ROAMFLAG_NONE;
    m_specialFlags = SPECIALFLAG_NONE;
    m_name_prefix = 0;
    m_MobSkillList = 0;

    m_AllowRespawn = 0;
    m_DropItemTime = 0;
    m_Family = 0;
    m_Type = MOBTYPE_NORMAL;
    m_Behaviour = BEHAVIOUR_NONE;
    m_SpawnType = SPAWNTYPE_NORMAL;
    m_SpawnTime = time_point::min();
    m_UncharmTime = std::chrono::system_clock::now() - 5min;
    m_NextSlidingHit = std::chrono::system_clock::now();
    m_AutoClaimed = false;
    m_EcoSystem = SYSTEM_UNCLASSIFIED;
    m_Element = 0;
    m_HiPCLvl = 0;
    m_HiPartySize = 0;
    m_THLvl = 0;
    m_ItemStolen = false;
    m_StealItemID = 0;
    m_autoTargetReady = true;
    m_autoTargetKiller = nullptr;

    strRank = 3;
    vitRank = 3;
    agiRank = 3;
    intRank = 3;
    mndRank = 3;
    chrRank = 3;
    attRank = 3;
    defRank = 3;
    accRank = 3;
    evaRank = 3;

    m_dmgMult = 100;

    m_giveExp = false;
    m_ExpPenalty = 0;
    m_neutral = false;
    m_Aggro = false;
    m_TrueDetection = 0;
    m_Detects = DETECT_NONE;
    m_Link = 0;

    m_battlefieldID = 0;
    m_bcnmID = 0;

    m_maxRoamDistance = 50.0f;
    aggroTimer = 1;
    m_disableScent = false;

    memset(&m_SpawnPoint, 0, sizeof(m_SpawnPoint));

    m_SpellListContainer = nullptr;
    PEnmityContainer = new CEnmityContainer(this);
    SpellContainer = new CMobSpellContainer(this);

    m_pixieLastCast = 0;

    // For Dyna Stats
    m_StatPoppedMobs = false;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CMobController>(this),
        std::make_unique<CTargetFind>(this));
}

const int8* CMobEntity::GetFamilyName()
{
    return (const int8*)m_FamilyName.c_str();
}

uint32 CMobEntity::getEntityFlags()
{
    return m_flags;
}

void CMobEntity::setEntityFlags(uint32 EntityFlags)
{
    m_flags = EntityFlags;
}

CMobEntity::~CMobEntity()
{
    delete PEnmityContainer;
    delete SpellContainer;
}

/************************************************************************
*                                                                       *
*  Время исчезновения монстра в секундах                                *
*                                                                       *
************************************************************************/

time_point CMobEntity::GetDespawnTime()
{
    return m_DespawnTimer;
}

void CMobEntity::SetDespawnTime(duration _duration)
{
    if (_duration > 0s)
    {
        m_DespawnTimer = server_clock::now() + _duration;
    }
    else
    {
        m_DespawnTimer = time_point::min();
    }
}

uint32 CMobEntity::GetRandomGil()
{

    int16 min = getMobMod(MOBMOD_GIL_MIN);
    int16 max = getMobMod(MOBMOD_GIL_MAX);

    if (min && max)
    {
        // make sure divide won't crash server
        if (max <= min)
        {
            max = min + 2;
        }

        if (max - min < 2)
        {
            max = min + 2;
            ShowWarning("CMobEntity::GetRandomGil Max value is set too low, defauting\n");
        }

        return tpzrand::GetRandomNumber(min, max);
    }

    float gil = (float)pow(GetMLevel(), 1.05f);

    if (gil < 1) {
        gil = 1;
    }

    uint16 highGil = (uint16)(gil / 3 + 4);

    if (max)
    {
        highGil = max;
    }

    if (highGil < 2) {
        highGil = 2;
    }

    // randomize it
    gil += tpzrand::GetRandomNumber(highGil);

    if (min && gil < min)
    {
        gil = min;
    }

    if (getMobMod(MOBMOD_GIL_BONUS) != 0)
    {
        gil *= (getMobMod(MOBMOD_GIL_BONUS) / 100.0f);
    }

    return (uint32)gil;
}

bool CMobEntity::CanDropGil()
{
    // smaller than 0 means drop no gil
    if (getMobMod(MOBMOD_GIL_MAX) < 0) return false;

    if (getMobMod(MOBMOD_GIL_MIN) > 0 || getMobMod(MOBMOD_GIL_MAX))
    {
        return true;
    }

    return getMobMod(MOBMOD_GIL_BONUS) > 0;
}

bool CMobEntity::CanStealGil()
{
    // TODO: Some mobs cannot be mugged
    return CanDropGil();
}

void CMobEntity::ResetGilPurse()
{
    uint32 purse = GetRandomGil() / ((tpzrand::GetRandomNumber(4, 7)));
    if (purse == 0)
        purse = GetRandomGil();
    setMobMod(MOBMOD_MUG_GIL, purse);
}

bool CMobEntity::CanRoamHome()
{
    if ((speed == 0 && !(m_roamFlags & ROAMFLAG_WORM)) || getMobMod(MOBMOD_NO_MOVE)) return false;

    if (getMobMod(MOBMOD_NO_DESPAWN) || map_config.mob_no_despawn || std::chrono::system_clock::now() > m_UncharmTime + 20s)
    {
        return true;
    }

    return distanceSquared(m_SpawnPoint, loc.p) < roam_home_distance * roam_home_distance;
}

bool CMobEntity::CanRoam()
{
    return !(m_roamFlags & ROAMFLAG_EVENT) && PMaster == nullptr && (speed > 0 || (m_roamFlags & ROAMFLAG_WORM)) && getMobMod(MOBMOD_NO_MOVE) == 0;
}

bool CMobEntity::CanLink(position_t* pos, int16 superLink)
{
    TracyZoneScoped;
    // handle super linking first
    if (superLink && getMobMod(MOBMOD_SUPERLINK) == superLink)
    {
        return true;
    }
    
    if (loc.zone->HasReducedVerticalAggro())
    {
        float verticalDistance = abs(loc.p.y - (*pos).y);
        if (verticalDistance > 3.5f)
        {
            return false;
        }
    }

    // can't link right now
    if (m_neutral)
    {
        return false;
    }

    if (getMobMod(MOBMOD_NO_LINK) > 0)
    {
        return false;
    }

    // Don't link I'm an underground worm
    if ((m_roamFlags & ROAMFLAG_WORM) && IsNameHidden())
    {
        return false;
    }

    // Don't link I'm an underground antlion
    if ((m_roamFlags & ROAMFLAG_AMBUSH) && IsNameHidden())
    {
        return false;
    }

    if (distanceSquared(loc.p, *pos) > intpow32(getMobMod(MOBMOD_LINK_RADIUS),2) )
    {
        return false;
    }

    // link only if I see him
    if (m_Detects & DETECT_SIGHT)
    {
        if (!facing(loc.p, *pos, 64))
        {
            return false;
        }
    }

    if (!PAI->PathFind->CanSeePoint(*pos))
    {
        return false;
    }
    return true;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

bool CMobEntity::CanDeaggro()
{
    return !(m_Type & MOBTYPE_NOTORIOUS || m_Type & MOBTYPE_BATTLEFIELD || isInDynamis() == true );
}

bool CMobEntity::IsFarFromHome()
{
    return distance(loc.p, m_SpawnPoint) > m_maxRoamDistance;
}

bool CMobEntity::CanBeNeutral()
{
    return !(m_Type & MOBTYPE_NOTORIOUS);
}

uint16 CMobEntity::TPUseChance()
{
    auto& MobSkillList = battleutils::GetMobSkillList(getMobMod(MOBMOD_SKILL_LIST));

    if (health.tp < 1000 || MobSkillList.empty() == true || !static_cast<CMobController*>(PAI->GetController())->IsWeaponSkillEnabled())
    {
        return 0;
    }

    if (health.tp == 3000 || (GetHPP() <= 50 && health.tp >= 2000) || (GetHPP() <= 25 && health.tp >= 1000))
    {
        return 10000;
    }

    return (uint16)getMobMod(MOBMOD_TP_USE_CHANCE);
}

void CMobEntity::setMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] = value;
}

int16 CMobEntity::getMobMod(uint16 type)
{
    return m_mobModStat[type];
}

void CMobEntity::addMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] += value;
}

void CMobEntity::defaultMobMod(uint16 type, int16 value)
{
    if (m_mobModStat[type] == 0)
    {
        m_mobModStat[type] = value;
    }
}

void CMobEntity::resetMobMod(uint16 type)
{
    m_mobModStat[type] = m_mobModStatSave[type];
}

int32 CMobEntity::getBigMobMod(uint16 type)
{
    return getMobMod(type) * 1000;
}

void CMobEntity::saveMobModifiers()
{
    m_mobModStatSave = m_mobModStat;
}

void CMobEntity::restoreMobModifiers()
{
    m_mobModStat = m_mobModStatSave;
}

void CMobEntity::HideHP(bool hide)
{
    if (hide)
    {
        m_flags |= FLAG_HIDE_HP;
    }
    else
    {
        m_flags &= ~FLAG_HIDE_HP;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::IsHPHidden()
{
    return m_flags & FLAG_HIDE_HP;
}


void CMobEntity::CallForHelp(bool call)
{
    if (call)
    {
        m_flags |= FLAG_CALL_FOR_HELP;
        m_OwnerID.clean();
    }
    else
    {
        m_flags &= ~FLAG_CALL_FOR_HELP;
    }
    updatemask |= UPDATE_COMBAT;
}

bool CMobEntity::CalledForHelp()
{
    return m_flags & FLAG_CALL_FOR_HELP;
}

void CMobEntity::Untargetable(bool untargetable)
{
    if (untargetable)
    {
        m_flags |= FLAG_UNTARGETABLE;
    }
    else
    {
        m_flags &= ~FLAG_UNTARGETABLE;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::IsUntargetable()
{
    return m_flags & FLAG_UNTARGETABLE;
}

void CMobEntity::DoAutoTarget()
{
    TracyZoneScoped;
    if (!m_autoTargetReady)
        return;
    m_autoTargetReady = false;

    // logic walk-thru:
    // check each alliance-member of mob claimer if they were engaged with this mob when it died
    // person who landed the final blow designates a new target for the alliance (closest mob to that person)
    // which is a mob that is trying to attack a player and can be attacked by the alliance (white or red name mob)
    // this way, when auto-target triggers, the entire alliance/party will always engage on the same mob together
    // but only if the character is facing the next target

    CCharEntity* POwner = nullptr;
    if (this->m_autoTargetKiller)
        POwner = m_autoTargetKiller;
    else if (this->m_OwnerID.id)
        POwner = zoneutils::GetChar(m_OwnerID.id);
    if (!POwner)
        return;
    CZone* PZone = zoneutils::GetZone(POwner->getZone());
    if (!PZone)
        return;

    if (PZone->GetType() != ZONETYPE_DYNAMIS)
    {
        POwner->ForAlliance([](CBattleEntity* PMemberBE) {
            if (PMemberBE && PMemberBE->objtype == TYPE_PC)
                ((CCharEntity*)PMemberBE)->m_autoTargetOverride = nullptr;
        });

        POwner->ForAlliance([this, POwner](CBattleEntity* PMemberBE) {
            bool success = false;

            if (PMemberBE && PMemberBE->objtype == TYPE_PC && PMemberBE->loc.zone->GetID() == this->loc.zone->GetID() &&
                ((CCharEntity*)PMemberBE)->m_LastEngagedTargID == this->targid && ((CCharEntity*)PMemberBE)->m_hasAutoTarget)
            {
                CCharEntity* PMember = (CCharEntity*)PMemberBE;
                std::unique_ptr<CBasicPacket> errMsg;
                if (PMember->m_autoTargetOverride)
                {
                    if (PMember->m_autoTargetOverride->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMember->m_autoTargetOverride) &&
                        !((CBattleEntity*)(PMember->m_autoTargetOverride)->IsNameHidden()) &&
                        distanceSquared(PMember->loc.p, PMember->m_autoTargetOverride->loc.p) < 29.0f * 29.0f)
                    {
                        auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                        success = controller->ChangeAutoTarget(PMember->m_autoTargetOverride->targid, PMember->loc.p, PMember->m_autoTargetOverride->loc.p);
                    }
                }
                else
                {
                    auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                    CMobEntity* PWinner = nullptr;
                    for (auto&& PPotentialTarget : PMember->SpawnMOBList)
                    {
                        CBattleEntity* PMob = (CBattleEntity*)PPotentialTarget.second;
                        CBattleEntity* PMobTarget = (CBattleEntity*)(PMob->GetEntity(PMob->GetBattleTargetID()));

                        if ((PMob->objtype == TYPE_MOB || PMob->objtype == TYPE_PET) &&
                            PMob->animation == ANIMATION_ATTACK &&
                            PMob->allegiance == ALLEGIANCE_MOB &&
                            PMember->IsMobOwner(PMob) &&
                            !PMob->IsNameHidden() &&
                            PMob->id != this->id &&
                            distanceSquared(PMember->loc.p, PMob->loc.p) < 29 * 29 &&
                            !PMember->m_autoTargetOverride &&
                            ((PMobTarget->objtype == TYPE_PC && PMember->IsPartiedWith((CCharEntity*)PMobTarget)) ||
                                (PMobTarget->objtype == TYPE_PET && PMobTarget->PMaster && PMobTarget->PMaster->objtype == TYPE_PC && PMember->IsPartiedWith((CCharEntity*)(PMobTarget->PMaster)))))
                        {
                            if (PWinner)
                            {
                                if (distanceSquared(PMob->loc.p, POwner->loc.p) < distanceSquared(PWinner->loc.p, POwner->loc.p))
                                    PWinner = (CMobEntity*)PMob;
                            }
                            else
                            {
                                PWinner = (CMobEntity*)PMob;
                            }
                        }
                    }
                    if (PWinner)
                    {
                        success = controller->ChangeAutoTarget(PWinner->targid, PMember->loc.p, PWinner->loc.p);
                        PMember->ForAlliance([PMember, PWinner](CBattleEntity* PMembermember) {
                            if (PMembermember->objtype == TYPE_PC && PMembermember->loc.zone->GetID() == PMember->loc.zone->GetID() &&
                                PMembermember->animation == ANIMATION_ATTACK)
                                ((CCharEntity*)PMembermember)->m_autoTargetOverride = (CBattleEntity*)PWinner;
                        });
                    }
                }
            }

            if (!success && PMemberBE && PMemberBE->objtype == TYPE_PC)
                ((CCharEntity*)PMemberBE)->m_LastEngagedTargID = 0;

        });
    }
    else // use dynamis version of checking all nearby players, not just alliance
    {
        PZone->ForEachChar([](CCharEntity* PChar) {
            if (PChar && PChar->objtype == TYPE_PC)
                PChar->m_autoTargetOverride = nullptr;
        });

        PZone->ForEachChar([this, POwner, PZone](CCharEntity* PChar) {
            bool success = false;

            if (PChar && PChar->objtype == TYPE_PC && PChar->loc.zone->GetID() == this->loc.zone->GetID() &&
                PChar->m_LastEngagedTargID == this->targid && PChar->m_hasAutoTarget)
            {
                CCharEntity* PMember = PChar;
                std::unique_ptr<CBasicPacket> errMsg;
                if (PMember->m_autoTargetOverride)
                {
                    if (PMember->m_autoTargetOverride->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMember->m_autoTargetOverride) &&
                        !((CBattleEntity*)(PMember->m_autoTargetOverride)->IsNameHidden()) &&
                        distanceSquared(PMember->loc.p, PMember->m_autoTargetOverride->loc.p) < 29.0f * 29.0f)
                    {
                        auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                        success = controller->ChangeAutoTarget(PMember->m_autoTargetOverride->targid, PMember->loc.p, PMember->m_autoTargetOverride->loc.p);
                    }
                }
                else
                {
                    auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                    CMobEntity* PWinner = nullptr;
                    for (auto&& PPotentialTarget : PMember->SpawnMOBList)
                    {
                        CBattleEntity* PMob = (CBattleEntity*)PPotentialTarget.second;

                        if ((PMob->objtype == TYPE_MOB || PMob->objtype == TYPE_PET) &&
                            PMob->animation == ANIMATION_ATTACK &&
                            PMob->allegiance == ALLEGIANCE_MOB &&
                            PMember->IsMobOwner(PMob) &&
                            !PMob->IsNameHidden() &&
                            PMob->id != this->id &&
                            distanceSquared(PMember->loc.p, PMob->loc.p) < 29 * 29 &&
                            !PMember->m_autoTargetOverride)
                        {
                            if (PWinner)
                            {
                                if (distanceSquared(PMob->loc.p, POwner->loc.p) < distanceSquared(PWinner->loc.p, POwner->loc.p))
                                    PWinner = (CMobEntity*)PMob;
                            }
                            else
                            {
                                PWinner = (CMobEntity*)PMob;
                            }
                        }
                    }
                    if (PWinner)
                    {
                        success = controller->ChangeAutoTarget(PWinner->targid, PMember->loc.p, PWinner->loc.p);
                        PZone->ForEachChar([PMember, PWinner](CCharEntity* PMembermember) {
                            if (PMembermember->objtype == TYPE_PC && PMembermember->loc.zone->GetID() == PMember->loc.zone->GetID() &&
                                PMembermember->animation == ANIMATION_ATTACK)
                                PMembermember->m_autoTargetOverride = (CBattleEntity*)PWinner;
                        });
                    }
                }
            }

            if (!success && PChar && PChar->objtype == TYPE_PC)
                PChar->m_LastEngagedTargID = 0;
        });
    }
}

void CMobEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && updatemask)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, UPDATE_ALL_MOB));

        // If this mob is charmed, it should sync with its master
        if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
        {
            ((CCharEntity*)PMaster)->pushPacket(new CPetSyncPacket((CCharEntity*)PMaster));
        }

        updatemask = 0;
    }
}

float CMobEntity::GetRoamDistance()
{
    return (float)getMobMod(MOBMOD_ROAM_DISTANCE) / 10.0f;
}

float CMobEntity::GetRoamRate()
{
    return (float)getMobMod(MOBMOD_ROAM_RATE) / 10.0f;
}

bool CMobEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
    }
    if (CBattleEntity::ValidTarget(PInitiator, targetFlags))
    {
        return true;
    }
    if (targetFlags & TARGET_PLAYER_DEAD && (m_Behaviour & BEHAVIOUR_RAISABLE)
        && isDead())
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER) && allegiance == PInitiator->allegiance && !isCharmed)
    {
        return true;
    }

    if (targetFlags & TARGET_NPC)
    {
        if (allegiance == PInitiator->allegiance && !(m_Behaviour & BEHAVIOUR_NOHELP) && !isCharmed)
        {
            return true;
        }
    }

    return false;
}

void CMobEntity::Spawn()
{
    TracyZoneScoped;
    CBattleEntity::Spawn();
    m_giveExp = true;
    m_ExpPenalty = 0;
    m_HiPCLvl = 0;
    m_HiPartySize = 0;
    m_THLvl = 0;
    m_ItemStolen = false;
    m_StealItemID = 0;
    m_autoTargetReady = true;
    m_autoTargetKiller = nullptr;
    m_DropItemTime = 1000;
    m_SpawnTime = server_clock::now();
    animationsub = (uint8)getMobMod(MOBMOD_SPAWN_ANIMATIONSUB);
    CallForHelp(false);

    PEnmityContainer->Clear();

    uint8 level = m_minLevel;

    // Generate a random level between min and max level
    if (m_maxLevel > m_minLevel)
    {
        level += tpzrand::GetRandomNumber(0, m_maxLevel - m_minLevel + 1);
    }

    SetMLevel(level);
    SetSLevel(level);//calculated in function

    mobutils::CalculateStats(this);
    mobutils::GetAvailableSpells(this);

    // spawn somewhere around my point
    loc.p = m_SpawnPoint;

    if (m_roamFlags & ROAMFLAG_STEALTH)
    {
        HideName(true);
        Untargetable(true);
    }

    // add people to my posse
    if (getMobMod(MOBMOD_ASSIST))
    {
        for (int8 i = 1; i < getMobMod(MOBMOD_ASSIST) + 1; i++)
        {
            CMobEntity* PMob = (CMobEntity*)GetEntity(targid + i, TYPE_MOB);

            if (PMob != nullptr)
            {
                PMob->setMobMod(MOBMOD_SUPERLINK, targid);
            }
        }
    }

    m_DespawnTimer = time_point::min();
    luautils::OnMobSpawn(this);

    // claim shield, happens after onmobspawn so that this can be added on the fly to individual mobs without any cluster restarts
    if (getMobMod(MOBMOD_CLAIM_SHIELD))
    {
        if (PAI->Internal_ClaimShieldState())
        {
            ShowInfo("MobID (%u) spawned with claimshield\n", this->id);
            // ensure mob doesn't perform any actions
            this->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_TERROR, EFFECT_TERROR, 1, 0, 20));
        }
        else
        {
            ShowError("MobID (%u) failed to spawn with claimshield\n", this->id);
        }
    }
}

void CMobEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}


void CMobEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    TracyZoneScoped;
    auto PSkill = state.GetSkill();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    int32 wsTargetID = luautils::onMobSkillFinished((CBaseEntity*)this, (CBaseEntity*)PTarget, (CMobSkill*)PSkill); // change WS target if needed
    if (wsTargetID != 0)
    {
        auto newTarget = GetEntity(wsTargetID);
        if (newTarget != nullptr)
        {
            PTarget = static_cast<CBattleEntity*>(newTarget);
        }
    }

    bool cover = false;

    if ((!PTarget) || (!PSkill))
    {
        return;
    }
    if (this->objtype == TYPE_MOB && PTarget->objtype == TYPE_PC)
    {
        PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    }

    auto PCoverTarget = battleutils::getCoverTarget(PTarget, this);
    if (PCoverTarget)
    {
        PTarget = PCoverTarget;
        if (PCoverTarget->StatusEffectContainer->HasStatusEffect(EFFECT_COVER) && PCoverTarget->StatusEffectContainer->GetStatusEffect(EFFECT_COVER)->GetPower() & 2)
            PCoverTarget->setModifier(Mod::COVERED_MP_FLAG, 1);
        cover = true;
    }

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    // store the skill used
    m_UsedSkillIds[PSkill->getID()] = GetMLevel();

    PAI->TargetFind->reset();

    float distance = PSkill->getDistance();
    uint8 findFlags = 0;
    if (PSkill->getFlag() & SKILLFLAG_HIT_ALL)
    {
        findFlags |= FINDFLAGS_HIT_ALL;
    }

    // Mob buff abilities also hit monster's pets
    if (PSkill->getValidTargets() == TARGET_SELF)
    {
        findFlags |= FINDFLAGS_PET;
    }

    if (PSkill->getValidTargets() & TARGET_PLAYER_DEAD)
    {
        findFlags |= FINDFLAGS_DEAD; // cait sith's Altana's Favor uses this
    }

    action.id = id;
    if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR)
        action.actiontype = ACTION_PET_MOBABILITY_FINISH;
    else if (PSkill->isJobAbility())
        action.actiontype = ACTION_JOBABILITY_FINISH;
    else if (PSkill->getID() < 256 || (PSkill->getID() > 2485 && PSkill->getID() < 2490))
        action.actiontype = ACTION_WEAPONSKILL_FINISH;
    else
        action.actiontype = ACTION_MOBABILITY_FINISH;
    action.actionid = PSkill->getID();

    if (PTarget && PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, (AOERADIUS)PSkill->getAoe(), PSkill->getRadius(), findFlags);
        }
        else if (PSkill->isConal())
        {
            float angle = 0.0f;

            if (this->m_Family == 62 || this->m_Family == 164)  // Cerb and Hydra families have wide Conals
            {
                angle = 90.0f; 
            }
            else if (this->m_Family >= 259 && this->m_Family <= 264 || this->m_Family >= 391 && this->m_Family <= 393) // Wyrms have slightly wider than normal
            {
                angle = 60.0f;
            }
            else if (PSkill->getID() == 2335) // Ixion's Lightning Spear is the only 120º Conal that we know of
            {
                angle = 120.0f;
            }
            else
            {
                angle = 45.0f;
            }
            if(PSkill->m_Aoe == 6) // Conal from center of mob
            {
                PAI->TargetFind->findWithinCone(PTarget, AOERADIUS_ATTACKER, distance, angle, findFlags, 0);
            }
            else if (PSkill->m_Aoe == 7) // Conal from center of mob in front and behind
            {
                PAI->TargetFind->findWithinCone(PTarget, AOERADIUS_ATTACKER, distance, angle, findFlags, 128);
                PAI->TargetFind->findWithinCone(PTarget, AOERADIUS_ATTACKER, distance, angle, findFlags, 0);
            }
            else // Conal in front centered on target, m_AoE 5 sets conal to rear
            {
                PAI->TargetFind->findWithinCone(PTarget, AOERADIUS_TARGET, distance, angle, findFlags, (PSkill->m_Aoe == 5)*128);
            }
        }
        else
        {
            if (this->objtype == TYPE_MOB && PTarget->objtype == TYPE_PC)
            {
                CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PTarget, this);
                if (PCoverAbilityUser != nullptr)
                {
                    PTarget = PCoverAbilityUser;
                }
            }

            PAI->TargetFind->findSingleTarget(PTarget, findFlags);
        }
    }

    uint16 targets = (uint16)PAI->TargetFind->m_targets.size();

    if (!PTarget || targets == 0)
    {
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = PSkill->getID();
        return;
    }

    PSkill->setTotalTargets(targets);
    PSkill->setTP(state.GetSpentTP());
    PSkill->setHPP(GetHPP());

    uint16 msg = 0;
    uint16 defaultMessage = PSkill->getMsg();

    bool first {true};
    for (auto&& PTarget : PAI->TargetFind->m_targets)
    {
        actionList_t& list = action.getNewActionList();

        list.ActionTargetID = PTarget->id;

        actionTarget_t& target = list.getNewActionTarget();

        list.ActionTargetID = PTarget->id;
        target.reaction = REACTION_HIT;
        target.speceffect = SPECEFFECT_HIT;
        target.animation = PSkill->getAnimationID();
        target.messageID = PSkill->getMsg();

        // reset the skill's message back to default
        PSkill->setMsg(defaultMessage);

        if (PTarget->isSuperJumped)
        {
            target.reaction = REACTION_EVADE;
            target.speceffect = SPECEFFECT_NONE;
            target.messageID = 188; // skill miss
            continue;
        }

        if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() != PETTYPE_JUG_PET)
        {
            if(static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR || static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_WYVERN)
            {
                target.animation = PSkill->getPetAnimationID();
            }
            target.param = luautils::OnPetAbility(PTarget, this, PSkill, PMaster, &action);
        }
        else
        {
            target.param = luautils::OnMobWeaponSkill(PTarget, this, PSkill, &action);
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", this, PTarget, PSkill->getID(), state.GetSpentTP(), &action);
            PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", PTarget, this, PSkill->getID(), state.GetSpentTP(), &action);
        }
        if (msg == 0)
        {
            msg = PSkill->getMsg();
        }
        else
        {
            msg = PSkill->getAoEMsg();
        }

        target.messageID = msg;

        if (PSkill->hasMissMsg())
        {
            target.reaction = REACTION_MISS;
            target.speceffect = SPECEFFECT_NONE;
            if (msg == PSkill->getAoEMsg())
                msg = 282;
        }
        else
        {
            target.reaction = REACTION_HIT;
            if (PSkill->m_GuardReaction)
            {
                target.reaction = REACTION_GUARD;
                PSkill->m_GuardReaction = false;
            }
        }

         // the target has been hit by the attack - proceed to perform knockback and skillchain check
        if (target.reaction == REACTION_HIT || target.reaction == REACTION_BLOCK || target.reaction == REACTION_GUARD)
        {
            target.speceffect = SPECEFFECT_RECOIL;
            target.knockback = PSkill->getKnockback();
            if (first && (PSkill->getPrimarySkillchain() != 0))
            {
                if (PSkill->getPrimarySkillchain())
                {
                    SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, PSkill->getPrimarySkillchain(),
                        PSkill->getSecondarySkillchain(), PSkill->getTertiarySkillchain());

                    if (effect != SUBEFFECT_NONE)
                    {
                        int32 skillChainDamage = battleutils::TakeSkillchainDamage(this, PTarget, target.param, nullptr);
                        if (skillChainDamage < 0)
                        {
                            target.addEffectParam = -skillChainDamage;
                            target.addEffectMessage = 384 + effect;
                        }
                        else
                        {
                            target.addEffectParam = skillChainDamage;
                            target.addEffectMessage = 287 + effect;
                        }
                        target.additionalEffect = effect;
                    }
                }
                first = false;
            }
        }

        if (this->objtype != TYPE_PET && this->PMaster != nullptr && this->PMaster->objtype != TYPE_PC)
            PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);

        if (PTarget->isDead())
        {
            battleutils::ClaimMob(PTarget, this);
        }
        battleutils::DirtyExp(PTarget, this);
    }

    PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->objtype == TYPE_MOB && (PTarget->isDead() || (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR)))
    {
        battleutils::ClaimMob(PTarget, this);
    }
    battleutils::DirtyExp(PTarget, this);

    if (cover)
        PCoverTarget->setModifier(Mod::COVERED_MP_FLAG, 0);
}

void CMobEntity::DistributeRewards()
{
    CCharEntity* PChar = (CCharEntity*)GetEntity(m_OwnerID.targid, TYPE_PC);

    if (PChar != nullptr && PChar->id == m_OwnerID.id)
    {
        StatusEffectContainer->KillAllStatusEffect();

        // NOTE: this is called for all alliance / party members!
        luautils::OnMobDeath(this, PChar);

        if (!CalledForHelp())
        {
            blueutils::TryLearningSpells(PChar, this);
            m_UsedSkillIds.clear();

            if (m_giveExp && !PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD) && zoneutils::GetZone(this->getZone())->GetType() != ZONETYPE_DYNAMIS)
            {
                charutils::DistributeExperiencePoints(PChar, this);
            }

            // check for gil (beastmen drop gil, some NMs drop gil)
            if (CanDropGil() || (map_config.all_mobs_gil_bonus > 0 && getMobMod(MOBMOD_GIL_MAX) >= 0)) // Negative value of MOBMOD_GIL_MAX is used to prevent gil drops in Dynamis/Limbus.
            {
                charutils::DistributeGil(PChar, this); // TODO: REALISATION MUST BE IN TREASUREPOOL
            }

            // RoE Mob kill event for all party members
            PChar->ForAlliance([this, PChar](CBattleEntity* PMember)
            {
                if (PMember->getZone() == PChar->getZone())
                {
                    roeutils::event(ROE_MOBKILL, (CCharEntity*)PMember, RoeDatagram("mob", (CMobEntity*)this));
                }
            });

            DropItems(PChar);
        }

    }
    else
    {
        luautils::OnMobDeath(this, nullptr);
    }
}

void CMobEntity::DropItems(CCharEntity* PChar)
{
    TracyZoneScoped;

    CDynamisHandler* PDynamisHandler = zoneutils::GetZone(this->getZone())->m_DynamisHandler;

    //Adds an item to the treasure pool
    auto AddItemToPool = [this, PChar, PDynamisHandler](uint16 ItemID, uint8 dropCount)
    {
        PChar->PTreasurePool->AddItem(ItemID, this, PDynamisHandler);

        // This used to cap the number of drops a mob can produce at 10, but
        // that's not the correct behavior.
        return false; //dropCount >= TREASUREPOOL_SIZE;
    };

    //Limit number of items that can drop to the treasure pool size
    uint8 dropCount = 0;

    DropList_t* DropList = itemutils::GetDropList(m_DropID);
    //ShowDebug(CL_CYAN"DropID: %u dropping with TH Level: %u\n" CL_RESET, m_DropID, m_THLvl);

    if (DropList != nullptr && !getMobMod(MOBMOD_NO_DROPS) && (DropList->Items.size() || DropList->Groups.size()))
    {
        // TH works by giving a droprate boost to one roll, and higher tiers give multiple normal rolls as well
        //
        // ex1: if TH mult=0.8 and maxRolls=1 (i.e. TH1):
        // original droprate of 1% => 1% + (1% * 0.8 * 99%) = 1.792%
        // original droprate of 50% => 50% + (50% * 0.8 * 50%) = 70 %
        // original droprate of 80% => 80% + (80% * 0.8 * 20%) = 92.8 %
        //
        // ex2: if TH mult=0.25 and maxRolls=3 (i.e. TH4):
        // first roll will follow the same as above except with mult=0.25
        // original droprate of 1% => 1% + (1% * 0.25 * 99%) ~ 1.24%
        // original droprate of 50% => 50% + (50% * 0.25 * 50%) = 56.25%
        // original droprate of 80% => 80% + (80% * 0.25 * 20%) = 84%
        // if the drop is not obtained on the first roll, 2 more attempts are given at the original rate
        // final chance at a drop for TH4 with an original rate of X (out of 1000), therefore:
        //
        // 1-(1-X/1000)^2*(1-(X+(X*(1000-X)/1000*X))/1000)
        //
        // explanation of above:
        // - inverse of (1-X/1000)^2*(1-(X+(X*(1000-X)/1000*X))/1000)
        // - the chance of not getting the first drop: (1-(X+(X*(1000-X)/1000*X))/1000)
        // - the chance of not getting the second drop AND not getting the third drop: (1-X/1000)^2

        uint8 maxRolls = 1;
        uint8 bonus = 0;
        float mult = 0.00f;
        if (m_THLvl == 1)
        {
            mult = 0.80f;
        }
        else if (m_THLvl == 2)
        {
            mult = 0.41f;
            maxRolls = 2;
        }
        else if (m_THLvl == 3)
        {
            mult = 0.03f;
            maxRolls = 3;
        }
        else if (m_THLvl == 4)
        {
            mult = 0.25f;
            maxRolls = 3;
        }
        else if (m_THLvl >= 5)
        {
            mult = 0.91f;
            maxRolls = 3;
        }

        //ShowDebug("m_THLvl was %u, mult was %.2f, maxRolls was %u\n",m_THLvl,mult,maxRolls);

        // handle all group drops from mob drop table
        uint16 groupCount = 0;
        for (const DropGroup_t& group : DropList->Groups)
        {
            // itemutils.cpp loads drop groups, starting at groupid 0 and sequentially
            // this means that if you have a dropid with two drop groups, groupid 1 and groupid 3, DropGroup_t contains 4 entities, 2 of which have rate=0
            // TODO: fix this in itemutils.cpp?
            uint16 rate = group.GroupRate;
            if(rate > 0){
                groupCount++;
                uint16 groupRateSum = 0;
                for (const DropItem_t& item : group.Items)
                {
                    groupRateSum += item.DropRate;
                }

                if(m_THLvl >= 1){
                    // This is a TH>0, apply the mult for the first roll
                    rate = rate + (rate * mult * (1000 - rate)/1000);
                }

                //Determine if this group should drop an item
                for (uint8 roll = 0; roll < maxRolls; ++roll)
                {
                    /*
                    std::string itemIDs = "";
                    for (const DropItem_t& item : group.Items)
                    {
                        itemIDs += std::to_string(item.ItemID) + ",";
                    }
                    ShowDebug(CL_CYAN"checking if group %u drops with rate %u total itemRates %u and items: %s\n" CL_RESET, groupCount, rate, groupRateSum, itemIDs);
                    */
                    if (((tpzrand::GetRandomNumber(1000) < rate) || m_THLvl > 68))
                    {
                        //Each item in the group is given its own weight range which is the previous value to the previous value + item.DropRate
                        //Such as 2 items with drop rates of 200 and 800 would be 0-199 and 200-999 respectively
                        uint16 previousRateValue = 0;
                        // total group's itemRates _should_ sum 1000, but if they don't, this normalizes it
                        uint16 itemRoll = tpzrand::GetRandomNumber(groupRateSum);
                        for (const DropItem_t& item : group.Items)
                        {
                            //ShowDebug(CL_CYAN"checking if itemid %u from group drops with itemroll %u (current rateTotal %u)\n" CL_RESET, item.ItemID, itemRoll, previousRateValue);
                            if (previousRateValue + item.DropRate > itemRoll)
                            {
                                if (AddItemToPool(item.ItemID, ++dropCount))
                                    return;
                                break;
                            }
                            previousRateValue += item.DropRate;
                        }
                        break;
                    }
                    //back to normal droprate
                    rate = group.GroupRate;
                }
            }
        }

        // handle all indvidual drops from mob drop table
        for (const DropItem_t& item : DropList->Items)
        {
            uint16 rate = item.DropRate;
            if(rate > 0){
                if(m_THLvl >= 1){
                    // This is a TH>0, apply the mult for the first roll
                    rate = rate + (rate * mult * (1000 - rate)/1000);
                }

                // determine if this item should drop
                for (uint8 roll = 0; roll < maxRolls; ++roll)
                {
                    //ShowDebug(CL_CYAN"checking if itemid %u drops with rate %u\n" CL_RESET, item.ItemID, rate);
                    if (((tpzrand::GetRandomNumber(1000) < rate) || m_THLvl > 68))
                    {
                        if (AddItemToPool(item.ItemID, ++dropCount))
                            return;
                        break;
                    }
                    //back to normal droprate
                    rate = item.DropRate;
                }
            }
        }
    }



    uint16 zoneID = PChar->getZone();

    bool validZone = ((zoneID > 0 && zoneID < 39) || (zoneID > 42 && zoneID < 134) || (zoneID > 135 && zoneID < 185) || (zoneID > 188 && zoneID < 255));

    if (validZone && charutils::GetRealExp(PChar->GetMLevel(), GetMLevel()) > 0)
    {

        //check for seal drops
        /* MobLvl >= 1 = Beastmen Seals ID=1126
        >= 50 = Kindred Seals ID=1127
        >= 75 = Kindred Crests ID=2955
        >= 90 = High Kindred Crests ID=2956
        */
        if (tpzrand::GetRandomNumber(100) < 20 && PChar->PTreasurePool->CanAddSeal() && !getMobMod(MOBMOD_NO_DROPS))
        {

            if (GetMLevel() >= 50) //b.seal & k.seal only
            {
                if (tpzrand::GetRandomNumber(2) == 0)
                {
                    if (AddItemToPool(1126, ++dropCount))
                        return;
                }
                else
                {
                    if (AddItemToPool(1127, ++dropCount))
                        return;
                }
            }
            else
            {
                //b.seal only
                if (AddItemToPool(1126, ++dropCount))
                    return;
            }
        }

        if (!m_Element)
            return;

        if (PChar->PParty == nullptr)
        {
            if (((PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) && (conquest::GetRegionOwner(PChar->loc.zone->GetRegionID()) <= 2)) ||
                (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) && PChar->loc.zone->GetRegionID() >= 28 && PChar->loc.zone->GetRegionID() <= 32) ||
                (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SIGIL) && PChar->loc.zone->GetRegionID() >= 33 && PChar->loc.zone->GetRegionID() <= 40)) &&
                tpzrand::GetRandomNumber(100) < 37)
            {
                if (AddItemToPool(4095 + m_Element, ++dropCount))
                    return;
            }
        }
        else
        {
            uint8 count = 0;
            CMobEntity* mob = this;
            PChar->ForParty([&count, &mob](CBattleEntity* member)
            {
                if ((member->objtype == TYPE_PC && member->getZone() == mob->getZone() && distanceSquared(member->loc.p, mob->loc.p) < 10000.0f) &&
                    (
                    ((member->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) && (conquest::GetRegionOwner(member->loc.zone->GetRegionID()) <= 2)) ||
                        (member->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) && member->loc.zone->GetRegionID() >= 28 && member->loc.zone->GetRegionID() <= 32) ||
                        (member->StatusEffectContainer->HasStatusEffect(EFFECT_SIGIL) && member->loc.zone->GetRegionID() >= 33 && member->loc.zone->GetRegionID() <= 40)) &&
                    tpzrand::GetRandomNumber(100) < 30)
                    )
                {
                    count++;
                }
            });

            while (count)
            {
                if (AddItemToPool(4095 + m_Element, ++dropCount))
                    return;
                count--;
            }

        }
        // Todo: Avatarite and Geode drops during day/weather. Much higher chance during weather than day.
        // Item element matches day/weather element, not mob crystal. Lv80+ xp mobs can drop Avatarite.
        // Wiki's have conflicting info on mob lv required for Geodes. One says 50 the other 75. I think 50 is correct.

        /* -- Wings implementation seems better
        uint8 effect = 0; // Begin Adding Crystals

        if (m_Element > 0)
        {
            uint8 regionID = PChar->loc.zone->GetRegionID();
            switch (regionID)
            {
                // Sanction Regions
                case REGION_WEST_AHT_URHGAN:
                case REGION_MAMOOL_JA_SAVAGE:
                case REGION_HALVUNG:
                case REGION_ARRAPAGO:
                    effect = 2;
                    break;
                // Sigil Regions
                case REGION_RONFAURE_FRONT:
                case REGION_NORVALLEN_FRONT:
                case REGION_GUSTABERG_FRONT:
                case REGION_DERFLAND_FRONT:
                case REGION_SARUTA_FRONT:
                case REGION_ARAGONEAU_FRONT:
                case REGION_FAUREGANDI_FRONT:
                case REGION_VALDEAUNIA_FRONT:
                    effect = 3;
                    break;
                // Signet Regions
                default:
                    effect = (conquest::GetRegionOwner(PChar->loc.zone->GetRegionID()) <= 2) ? 1 : 0;
                    break;
            }
        }
        uint8 crystalRolls = 0;
        PChar->ForParty([this, &crystalRolls, &effect](CBattleEntity* PMember)
        {
            switch(effect)
            {
                case 1:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) && PMember->getZone() == getZone() && distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                case 2:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) && PMember->getZone() == getZone() && distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                case 3:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGIL) && PMember->getZone() == getZone() && distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                default:
                    break;
            }
        });
        for (uint8 i = 0; i < crystalRolls; i++)
        {
            if (tpzrand::GetRandomNumber(100) < 20 && AddItemToPool(4095 + m_Element, ++dropCount))
            {
                return;
            }
        }
        */
    }
}


bool CMobEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    TracyZoneScoped;
    auto skill_list_id {getMobMod(MOBMOD_ATTACK_SKILL_LIST)};
    if (skill_list_id)
    {
        auto attack_range {GetMeleeRange()};
        auto skillList {battleutils::GetMobSkillList(skill_list_id)};
        if (!skillList.empty())
        {
            auto skill {battleutils::GetMobSkill(skillList.front())};
            if (skill)
            {
                attack_range = (uint8)skill->getDistance();
            }
        }
        if (!PAI->GetController()->IsAutoAttackEnabled())
        {
            return false;
        }
        else if (distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize > attack_range)
        {
            if (!this->speed || !(this->PAI->PathFind->IsFollowingPath() || this->PAI->PathFind->IsFollowingScriptedPath()))
                return false; // i must be chasing or not bound

            float bonusRange = 2;
            if (PTarget->speed >= this->speed)
                bonusRange = this->speed / PTarget->speed * 2;

            // attempt to hit a running target, increase range slightly
            if (std::chrono::system_clock::now() > this->m_NextSlidingHit && distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize < attack_range + bonusRange)
            {
                std::chrono::duration delay = std::chrono::milliseconds(this->GetWeaponDelay(false));
                if (this->m_Type & MOBTYPE_NOTORIOUS || this->m_Type & MOBTYPE_BATTLEFIELD || this->m_Type & MOBTYPE_EVENT)
                {
                    delay = std::chrono::milliseconds(tpzrand::GetRandomNumber(delay.count()*2, delay.count()*4));
                }
                else
                {
                    delay = std::chrono::milliseconds(tpzrand::GetRandomNumber(delay.count()*3, delay.count()*6));
                }
                this->m_NextSlidingHit = std::chrono::system_clock::now() + delay;
                return true;
            }
            return false;
        }
        return true;
    }
    else
    {
        return CBattleEntity::CanAttack(PTarget, errMsg);
    }
}

void CMobEntity::OnEngage(CAttackState& state)
{
    CBattleEntity::OnEngage(state);
    luautils::OnMobEngaged(this, state.GetTarget());
    unsigned int range = this->getMobMod(MOBMOD_ALLI_HATE);
    if (range != 0)
    {
        CBaseEntity* PTarget = state.GetTarget();
        CBaseEntity* PPet = nullptr;
        if (PTarget->objtype == TYPE_PET)
        {
            PPet = state.GetTarget();
            PTarget = ((CPetEntity*)PTarget)->PMaster;
        }
        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->ForAlliance([this, PTarget, range](CBattleEntity* PMember)
            {
                auto currentDistance = distance(PMember->loc.p, PTarget->loc.p);
                if (currentDistance < range)
                    this->PEnmityContainer->AddBaseEnmity(PMember);
            });
            this->PEnmityContainer->UpdateEnmity((PPet ? (CBattleEntity*)PPet : (CBattleEntity*)PTarget), 0, 1); // Set VE so target doesn't change
        }
    }

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

void CMobEntity::FadeOut()
{
    CBaseEntity::FadeOut();
    PEnmityContainer->Clear();
}

void CMobEntity::OnDeathTimer()
{
    if (!(m_Behaviour & BEHAVIOUR_RAISABLE))
        PAI->Despawn();
}

void CMobEntity::OnDespawn()
{
    FadeOut();
    m_SpawnTime = time_point::min();
    m_AutoClaimed = false;
    PAI->Internal_Respawn(std::chrono::milliseconds(m_RespawnTime));
    luautils::OnMobDespawn(this);
    PAI->ClearActionQueue();
    //#event despawn
    PAI->EventHandler.triggerListener("DESPAWN", this);
    this->loc.p = m_SpawnPoint; // push back to spawn point so camps don't get overrun with disappeared/dead mobs
}

void CMobEntity::Die()
{
    TracyZoneScoped;
    if (this->PAI && this->PAI->GetCurrentState() && this->PAI->GetCurrentState()->m_id == CLAIMSHIELD_STATE)
    {
        this->health.hp = 1;
        return;
    }

    DoAutoTarget();
    m_THLvl = PEnmityContainer->GetHighestTH();
    PEnmityContainer->Clear();
    PAI->ClearStateStack();
    if (PPet != nullptr && PPet->isAlive() && GetMJob() == JOB_SMN)
    {
        PPet->Die();
    }
    PAI->Internal_Die(15s);
    CBattleEntity::Die();
    PAI->QueueAction(queueAction_t(std::chrono::milliseconds(m_DropItemTime), false, [this](CBaseEntity* PEntity) {
        if (static_cast<CMobEntity*>(PEntity)->isDead())
        {
            if (PLastAttacker)
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_DEFEATS_TARG));
            else
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));

            DistributeRewards();
            m_OwnerID.clean();
            PAI->ClearActionQueue();
        }
    }));
    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CMobEntity::OnDisengage(CAttackState& state)
{
    PAI->PathFind->Clear();
    PEnmityContainer->Clear();

    if (getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        SetDespawnTime(std::chrono::seconds(getMobMod(MOBMOD_IDLE_DESPAWN)));
    }
    // this will let me decide to walk home or despawn
    m_neutral = true;

    m_OwnerID.clean();

    CBattleEntity::OnDisengage(state);

    luautils::OnMobDisengage(this);
}

void CMobEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CBattleEntity::OnCastFinished(state, action);

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

bool CMobEntity::OnAttack(CAttackState& state, action_t& action)
{
    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    if (getMobMod(MOBMOD_ATTACK_SKILL_LIST))
    {
        return static_cast<CMobController*>(PAI->GetController())->MobSkill(getMobMod(MOBMOD_ATTACK_SKILL_LIST));
    }
    else
    {
        return CBattleEntity::OnAttack(state, action);
    }
}

int32 CMobEntity::PixieGetAmity()
{
    TracyZoneScoped;
    // Prevent spamming the DB with calls
    time_t now = time(NULL);
    if (g_pixieLastAmityRefresh + 60 < now) {
        int32 ret = Sql_Query(SqlHandle, "SELECT value FROM server_variables WHERE name = 'PixieAmity';");
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS) {
            g_pixieAmity = Sql_GetIntData(SqlHandle, 0);
        }
        g_pixieLastAmityRefresh = now;
    }
    int32 amity = g_pixieAmity;
    if (amity < -255) {
        amity = -255;
    }
    if (amity > 255) {
        amity = 255;
    }
    return amity;
}

uint32 CMobEntity::PixieGetHealHateThreshold(CCharEntity* PChar)
{
    int32 amity = PixieGetAmity();
    if (amity >= 200) {
        // Pixies extremely happy, will cure even most offenders
        return 50;
    }
    if (amity >= 50) {
        // Will generally cure most players
        return 20;
    }
    if (amity >= -50) {
        // Default state
        return 10;
    }
    if (amity >= -100) {
        // Pixies are afraid, will not cure easily
        return 5;
    }
    // Pixies on the verge of extinction, will not cure anyone
    // who's ever touched a pixie (unless hate was reset)
    return 1;
}

void CMobEntity::PixieTryHealPlayer(CCharEntity* PChar)
{
    TracyZoneScoped;
    time_t now = time(NULL);
    SpellID spell = SpellID::NULLSPELL;
    if (!PAI) {
        return;
    }
    CMobController* controller = static_cast<CMobController*>(PAI->GetController());
    if (!controller) {
        return;
    }
    if (getMobMod(MOBMOD_PIXIE) <= 0) {
        return;
    }
    if (m_pixieLastCast + 30 >= now) {
        // Must rest between casts (TODO: Check real value)
        return;
    }
    if (PChar->m_pixieHate >= PixieGetHealHateThreshold(PChar)) {
        // TODO: Find real values
        // You killed my relatives so I don't care if you die
        return;
    }
    if (!controller->CanDetectTarget(PChar, false, true)) {
        // Must be able to detect the player to cast
        return;
    }
    if (PAI->IsEngaged())
    {
        // WINGSCUSTOM Don't cure or raise players while pixie is engaged
        return;
    }
    if (PChar->isDead()) {
        spell = SpellID::Raise_III;
    }
    else if (PChar->GetHPP() <= 90) {
        // TODO: Check what's the cure threshold on retail
        int32 max_hp = PChar->GetMaxHP();
        int32 current_hp = PChar->health.hp;
        int32 to_cure = max_hp - current_hp;
        if (to_cure < 0) {
            to_cure = 0;
        }
        if (to_cure > 0) {
            // Set according to the soft cap of each cure
            if (to_cure <= 30) {
                spell = SpellID::Cure;
            }
            else if (to_cure <= 90) {
                spell = SpellID::Cure_II;
            }
            else if (to_cure <= 190) {
                spell = SpellID::Cure_III;
            }
            else if (to_cure <= 380) {
                spell = SpellID::Cure_IV;
            }
            else {
                spell = SpellID::Cure_V;
            }
        }
    }
    if (spell != SpellID::NULLSPELL) {
        if (controller->Cast(PChar->targid, spell)) {
            m_pixieLastCast = now;
        }
    }
}

bool CMobEntity::PixieShouldSpawn()
{
    int32 amity = PixieGetAmity();
    if (loc.zone->GetRegionID() < 33 || loc.zone->GetRegionID() > 40) {
        // Pixies in the present require higher amity
        amity -= 300;
    }
    if (amity >= -50) {
        return true;
    }
    if (amity <= -150) {
        return false;
    }
    int32 chance = amity + 150;
    return (tpzrand::GetRandomNumber(100) < chance);
}
