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

#include "weaponskill_state.h"
#include "../ai_container.h"
#include "../../entities/battleentity.h"
#include "../../packets/action.h"
#include "../../utils/battleutils.h"
#include "../../weapon_skill.h"
#include "../../status_effect_container.h"
#include "../../packets/char_health.h"

CWeaponSkillState::CWeaponSkillState(CBattleEntity* PEntity, uint16 targid, uint16 wsid) :
    CState(PEntity, targid),
    m_PEntity(PEntity)
{
    m_id = WEAPONSKILL_STATE;

    auto skill = battleutils::GetWeaponSkill(wsid);
    if (!skill)
    {
        throw CStateInitException(std::make_unique<CMessageBasicPacket>(PEntity, PEntity, 0, 0, MSGBASIC_CANNOT_USE_WS));
    }

    auto target_flags = battleutils::isValidSelfTargetWeaponskill(wsid) ? TARGET_SELF : TARGET_ENEMY;
    auto PTarget = m_PEntity->IsValidTarget(m_targid, target_flags, m_errorMsg);

    if (!PTarget || m_errorMsg)
    {
        throw CStateInitException(std::move(m_errorMsg));
    }
    if (!m_PEntity->PAI->TargetFind->canSee(&PTarget->loc.p))
    {
        throw CStateInitException(std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
    }
    m_PSkill = std::make_unique<CWeaponSkill>(*skill);

    //m_castTime = std::chrono::milliseconds(m_PSkill->getActivationTime());

    action_t action;
    action.id = m_PEntity->id;
    action.actiontype = ACTION_WEAPONSKILL_START;

    actionList_t& actionList = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();

    actionTarget.reaction = REACTION_NONE;
    actionTarget.speceffect = SPECEFFECT_NONE;
    actionTarget.animation = 0;
    actionTarget.param = m_PSkill->getID();
    actionTarget.messageID = 43;
    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
}

CWeaponSkill* CWeaponSkillState::GetSkill()
{
    return m_PSkill.get();
}

void CWeaponSkillState::SpendCost()
{
    auto tp = 0;
    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI))
    {
        tp = m_PEntity->addTP(-1000);
    }
    else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SEKKANOKI))
    {
        tp = m_PEntity->addTP(-1000);
        //m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SEKKANOKI);
        //moved to later on so we can check to disable TP bonus effects
    }
    else
    {
        tp = m_PEntity->health.tp;

        if (m_PEntity->getMod(Mod::WS_NO_DEPLETE) <= tpzrand::GetRandomNumber(100))
        {
            m_PEntity->health.tp = 0;
        }
    }

    if (tpzrand::GetRandomNumber(100) < m_PEntity->getMod(Mod::CONSERVE_TP))
    {
        m_PEntity->addTP(tpzrand::GetRandomNumber(10, 200));
    }

    if (m_PEntity->objtype == TYPE_PC)
    {
        m_PEntity->updatemask |= UPDATE_HP;
        ((CCharEntity*)m_PEntity)->pushPacket(new CCharHealthPacket((CCharEntity*)m_PEntity));
    }

    m_spent = tp;
}

bool CWeaponSkillState::Update(time_point tick)
{
    if (!IsCompleted())
    {
        action_t action;
        auto PTarget{ GetTarget() };
        /*
        if (distance(m_PEntity->loc.p, PTarget->loc.p) > (float)(m_PSkill->getRange()))
        {
            if (m_PEntity->objtype == TYPE_PC)
                ((CCharEntity*)m_PEntity)->pushPacket(new CMessageBasicPacket(m_PEntity, m_PEntity, (int32)(PTarget->id), 0, 4)); // the [target] is too far away.
            Complete();
            return true;
        }
        */
        SpendCost();
        m_PEntity->OnWeaponSkillFinished(*this, action);
        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", m_PEntity, PTarget, m_PSkill->getID(), m_spent, &action);
        PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", PTarget, m_PEntity, m_PSkill->getID(), m_spent, &action);
        auto delay = m_PSkill->getAnimationTime();
        m_finishTime = tick + delay;
        Complete();
    }
    else if (tick > m_finishTime)
    {
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_EXIT", m_PEntity, m_PSkill->getID());
        return true;
    }
    return false;
}

void CWeaponSkillState::Cleanup(time_point tick)
{
    //#TODO: interrupt an in progress ws
}
