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

#include "controller.h"

#include "../ai_container.h"
#include "../../entities/battleentity.h"
#include "../../utils/battleutils.h"
#include "../../weapon_skill.h"

CController::CController(CBattleEntity* _POwner) :
    m_Tick(server_clock::now()),
    POwner(_POwner)
{}

void CController::Despawn()
{
    if (POwner)
    {
        POwner->PAI->Internal_Despawn();
    }
}

void CController::Reset()
{
}

bool CController::Cast(uint16 targid, SpellID spellid)
{
    if (POwner)
    {
        if (POwner->objtype == TYPE_PC && POwner->PAI->GetCurrentState() && POwner->PAI->GetCurrentState()->m_id == MAGIC_STATE)
        {
            //ShowDebug("Got spellcast request while already spellcasting...\n");
            if (POwner->PAI->GetCurrentState()->IsCompleted())
            {
                //ShowDebug("Queueing another spellcast...\n");
                POwner->PAI->m_queuedSpellTargId = targid;
                POwner->PAI->m_queuedSpell = spellid;
                return true;
            }
            else
            {
                return false;
            }
        }
		return POwner->PAI->Internal_Cast(targid, spellid);
    }
    return false;
}

bool CController::Engage(uint16 targid)
{
    if (POwner)
    {
        bool ret = POwner->PAI->Internal_Engage(targid);
        if (ret && POwner->objtype == TYPE_PC && targid)
        {
            ((CCharEntity*)POwner)->m_LastEngagedTargID = targid;
            //ShowDebug("LETID updated.\n");
        }
        return ret;
    }
    return false;
}

bool CController::ChangeTarget(uint16 targid)
{
    if (POwner)
    {
        bool ret = POwner->PAI->Internal_ChangeTarget(targid);
        if (ret && POwner->objtype == TYPE_PC && targid)
        {
            ((CCharEntity*)POwner)->m_LastEngagedTargID = targid;
            //ShowDebug("LETID updated.\n");
        }
        return ret;
    }
    return false;
}

bool CController::Disengage()
{
    if (POwner)
    {
        return POwner->PAI->Internal_Disengage();
    }
    return false;
}

bool CController::WeaponSkill(uint16 targid, uint16 wsid)
{
    if (POwner && POwner->GetEntity(targid))
    {
        CBattleEntity* PTarget = (CBattleEntity*)(POwner->GetEntity(targid));
        CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(wsid);
        float dist = distance(POwner->loc.p, PTarget->loc.p);
        // Special casing Behemoth mob size - TODO: Get a comprehensive list of how far we should be able to weaponskill from on larger mobs
        if (PWeaponSkill->getRange() <= 5 && PTarget->objtype == TYPE_MOB)
        {
            CMobEntity* mob = (CMobEntity*)PTarget;
            if (mob->m_Family == 51 || mob->m_Family == 479) // Behemoth or King Behemoth
            {
                // Allow a reach from approx 6 yalms based on a model size of 4
                // Behe's model starts at 5.3.  6 yalms gives some room for TA/SA
                dist = dist - PTarget->m_ModelSize / 4.0;
            }
        }

        if (dist > (float)(PWeaponSkill->getRange()))
        {
            if (POwner->objtype == TYPE_PC)
                ((CCharEntity*)POwner)->pushPacket(new CMessageBasicPacket(POwner, PTarget, (int32)(PTarget->id), 0, 4)); // the [target] is too far away.
            return false;
        }
        else
        {
            return POwner->PAI->Internal_WeaponSkill(targid, wsid);
        }
    }
    return false;
}

bool CController::IsAutoAttackEnabled()
{
    return m_AutoAttackEnabled;
}

void CController::SetAutoAttackEnabled(bool enabled)
{
    m_AutoAttackEnabled = enabled;
}

bool CController::IsWeaponSkillEnabled()
{
    return m_WeaponSkillEnabled;
}

void CController::SetWeaponSkillEnabled(bool enabled)
{
    m_WeaponSkillEnabled = enabled;
}

bool CController::IsMagicCastingEnabled()
{
    return m_MagicCastingEnabled;
}

void CController::SetMagicCastingEnabled(bool enabled)
{
    m_MagicCastingEnabled = enabled;
}
