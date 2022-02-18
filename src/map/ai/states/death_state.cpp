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

#include "death_state.h"

#include "../../entities/battleentity.h"
#include "../../entities/charentity.h"
#include "../../packets/menu_raisetractor.h"
#include "../ai_container.h"
#include "../../status_effect.h"
#include "../../status_effect_container.h"

CDeathState::CDeathState(CBattleEntity* PEntity, duration death_time) :
    CState(PEntity, PEntity->targid),
    m_PEntity(PEntity),
    m_deathTime(death_time),
    m_raiseTime(GetEntryTime())
{
    m_id = DEATH_STATE;

    m_PEntity->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DEATH, true);

    m_PEntity->animation = ANIMATION_DEATH;
    m_PEntity->updatemask |= UPDATE_HP;
    if (m_PEntity->PAI->PathFind)
    {
        m_PEntity->PAI->PathFind->Clear();
    }

}

bool CDeathState::Update(time_point tick)
{
    CCharEntity* PChar = nullptr;
    if (m_PEntity->objtype == TYPE_PC) {
        PChar = static_cast<CCharEntity*>(m_PEntity);
    }
    if (IsCompleted() || m_PEntity->animation != ANIMATION_DEATH)
    {
        return true;
    }
    else if (m_PEntity->objtype == TYPE_PC && static_cast<CCharEntity*>(m_PEntity)->health.hp > 0)
    {
        Complete();
        m_PEntity->animation = ANIMATION_NONE;
        static_cast<CCharEntity*>(m_PEntity)->updatemask |= UPDATE_ALL_CHAR;
    }
    else if (tick > GetEntryTime() + m_deathTime && !IsCompleted())
    {
        Complete();
        m_PEntity->OnDeathTimer();
    }
    else if (m_PEntity->objtype == TYPE_PC && PChar && tick > GetEntryTime() + 8s && !IsCompleted() &&
        (!m_raiseSent || PChar->m_resendRaise) && m_PEntity->isDead())
    {
        if (PChar->m_hasRaise)
        {
            PChar->pushPacket(new CRaiseTractorMenuPacket(PChar, TYPE_RAISE));
            m_raiseSent = true;
            PChar->m_resendRaise = false;
        }
    }
    return false;
}
