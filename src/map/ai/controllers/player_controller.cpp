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

#include "player_controller.h"

#include "../ai_container.h"
#include "../../ability.h"
#include "../states/death_state.h"
#include "../../entities/charentity.h"
#include "../../items/item_weapon.h"
#include "../../packets/char_update.h"
#include "../../packets/lock_on.h"
#include "../../utils/battleutils.h"
#include "../../utils/charutils.h"
#include "../../recast_container.h"
#include "../../latent_effect_container.h"
#include "../../status_effect_container.h"
#include "../../weapon_skill.h"
#include "../../roe.h"

CPlayerController::CPlayerController(CCharEntity* _PChar) :
    CController(_PChar)
{
}

void CPlayerController::Tick(time_point)
{}

bool CPlayerController::Cast(uint16 targid, SpellID spellid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    if (!PChar->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<uint16>(spellid), 0))
    {
        return CController::Cast(targid, spellid);
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_CAST));
        return false;
    }
}

bool CPlayerController::Engage(uint16 targid)
{
    //#TODO: pet engage/disengage
    std::unique_ptr<CBasicPacket> errMsg;
    auto PChar = static_cast<CCharEntity*>(POwner);
    auto PTarget = PChar->IsValidTarget(targid, TARGET_ENEMY, errMsg);

    if (PTarget)
    {
        if (distanceSquared(PChar->loc.p, PTarget->loc.p) < 30*30)
        {
            if (CController::Engage(targid))
            {
                PChar->PLatentEffectContainer->CheckLatentsWeaponDraw(true);
                PChar->pushPacket(new CLockOnPacket(PChar, PTarget));
                return true;
            }
        }
        else
        {
            errMsg = std::make_unique<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY);
        }
    }
    if (errMsg)
    {
        PChar->HandleErrorMessage(errMsg);
    }
    return false;
}

bool CPlayerController::ChangeTarget(uint16 targid)
{
    return CController::ChangeTarget(targid);
}

// Checks that the next target is in front of the player when an autotarget occurs during combat
bool CPlayerController::ChangeAutoTarget(uint16 targid, position_t &playerPos, position_t &mobPos)
{
    if (map_config.autotarget_qol) // autotarget is radial if qol enabled so skip position check
    {
        return CController::ChangeTarget(targid);
    }
    // mob must be in front of player
    if (infront(mobPos, playerPos, 128))
    {
        return CController::ChangeTarget(targid);
    }
    return false;
}

bool CPlayerController::Disengage()
{
    return CController::Disengage();
}

bool CPlayerController::Ability(uint16 targid, uint16 abilityid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    // verify the ability can be used before changing state
    if (PChar->PAI->CanChangeState() && CanUseAbility(targid, abilityid)) 
    {
        return PChar->PAI->Internal_Ability(targid, abilityid);
    }
    else
    {
        return false;
    }
}

bool CPlayerController::RangedAttack(uint16 targid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    uint8 anim = PChar->animation;
    if (PChar->PAI->GetCurrentState() && PChar->PAI->GetCurrentState()->m_id == RANGE_STATE)
    {
        //ShowDebug("Got ranged attack request while already ranged attacking...\n");
        if (PChar->PAI->GetCurrentState()->IsCompleted())
        {
            //ShowDebug("Queueing another ranged attack...\n");
            PChar->PAI->m_queuedRangedAttack = targid;
            return true;
        }
        else
        {
            return false;
        }
    }
    else if (anim != ANIMATION_NONE && anim != ANIMATION_ATTACK)
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
    }
    else if (PChar->PAI->GetCurrentState() && PChar->PAI->GetCurrentState()->m_id == ABILITY_STATE)
    {
        return false;
    }
    else if (PChar->PAI->CanChangeState())
    {
        return PChar->PAI->Internal_RangedAttack(targid);
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER));
    }
    return false;
}

bool CPlayerController::UseItem(uint16 targid, uint8 loc, uint8 slotid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        return PChar->PAI->Internal_UseItem(targid, loc, slotid);
    }
    return false;
}

bool CPlayerController::WeaponSkill(uint16 targid, uint16 wsid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        //#TODO: put all this in weaponskill_state
        CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(wsid);

        if (PWeaponSkill == nullptr)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_WS));
            return false;
        }

        if (!charutils::hasWeaponSkill(PChar, PWeaponSkill->getID()))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_WS));
            return false;
        }

        if (PChar->StatusEffectContainer->HasStatusEffect({EFFECT_AMNESIA, EFFECT_IMPAIRMENT}) ||
            (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_PATHOS) && (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_PATHOS)->GetPower() & 2)))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_ANY_WS));
            return false;
        }

        if (PChar->health.tp < 1000)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NOT_ENOUGH_TP));
            return false;
        }

        if (PWeaponSkill->getType() == SKILL_ARCHERY || PWeaponSkill->getType() == SKILL_MARKSMANSHIP)
        {
            auto PItem = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));
            auto weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_RANGED]);
            auto ammo = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_AMMO]);

            // before allowing ranged weapon skill...
            if (PItem == nullptr ||
                !weapon || !weapon->isRanged() ||
                !ammo || !ammo->isRanged() ||
                PChar->equip[SLOT_AMMO] == 0)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON));
                return false;
            }
        }

        std::unique_ptr<CBasicPacket> errMsg;
        auto PTarget = PChar->IsValidTarget(targid, battleutils::isValidSelfTargetWeaponskill(wsid) ? TARGET_SELF : TARGET_ENEMY, errMsg);

        if (PTarget)
        {
            if (!facing(PChar->loc.p, PTarget->loc.p, 64) && PTarget != PChar)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGBASIC_CANNOT_SEE));
                return false;
            }
            if (distance(PChar->loc.p, PTarget->loc.p) > PWeaponSkill->getRange())
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY));
                return false;
            }
            roeutils::event(ROE_WSKILL_USE, PChar, RoeDatagramList{});

            m_lastWeaponSkill = PWeaponSkill;

            return CController::WeaponSkill(targid, wsid);
        }
        else if (errMsg)
        {
            PChar->pushPacket(std::move(errMsg));
        }
    }
    else
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_WS));
    }
    return false;
}

time_point CPlayerController::getLastAttackTime()
{
    return m_lastAttackTime;
}

void CPlayerController::setLastAttackTime(time_point _lastAttackTime)
{
    m_lastAttackTime = _lastAttackTime;
}

void CPlayerController::setLastErrMsgTime(time_point _LastErrMsgTime)
{
    m_errMsgTime = _LastErrMsgTime;
}

time_point CPlayerController::getLastErrMsgTime()
{
    return m_errMsgTime;
}

CWeaponSkill* CPlayerController::getLastWeaponSkill()
{
    return m_lastWeaponSkill;
}

bool CPlayerController::CanUseAbility(uint16 targid, uint16 abilityid)
{
    auto PChar = static_cast<CCharEntity*>(POwner);
    std::unique_ptr<CAbility> uniquePAbility = std::make_unique<CAbility>(*ability::GetAbility(abilityid));
    auto PAbility = uniquePAbility.get();
    
    if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER));
        return false;
    }
    if (PChar->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }) ||
        (!PAbility->isPetAbility() && !charutils::hasAbility(PChar, PAbility->getID())) ||
        (PAbility->isPetAbility() && !charutils::hasPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY)) ||
        (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_PATHOS) && (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_PATHOS)->GetPower() & 1)))
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
        return false;
    }
    std::unique_ptr<CBasicPacket> errMsg;
     
    auto PTarget = PChar->IsValidTarget(targid, PAbility->getValidTarget(), errMsg);
    if (PTarget)
    {
        if (PChar != PTarget && distance(PChar->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY));
            return false;
        }
        if (!PChar->PAI->TargetFind->canSee(&PTarget->loc.p))
        {
            errMsg = std::make_unique<CMessageBasicPacket>(PChar, PTarget, PAbility->getID(), 0, MSGBASIC_CANNOT_PERFORM_ACTION);
            PChar->HandleErrorMessage(errMsg);
            return false;
        }
        if (PAbility->getID() >= ABILITY_HEALING_RUBY)
        {
            // Blood pact MP costs are stored under animation ID
            if (PChar->health.mp < PAbility->getAnimationID())
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                return false;
            }
        }
        CBaseEntity* PMsgTarget = PChar;
        int32 errNo = luautils::OnAbilityCheck(PChar, PTarget, PAbility, &PMsgTarget);
        if (errNo != 0)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PMsgTarget, PAbility->getID(), PAbility->getID(), errNo));
            return false;
        }
        return true;
    }
    PChar->HandleErrorMessage(errMsg);
    return false;
}