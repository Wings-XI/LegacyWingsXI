/*
===========================================================================

this document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.

===========================================================================
*/

#include "claimshield_state.h"
#include "../ai_container.h"
#include "../../entities/battleentity.h"
#include "../../entities/mobentity.h"
#include "../../status_effect_container.h"
#include "../../utils/battleutils.h"
#include "../../mob_modifier.h"

CClaimShieldState::CClaimShieldState(CBaseEntity* PEntity) :
    CState(PEntity, 0)
{
    m_id = CLAIMSHIELD_STATE;
}


bool CClaimShieldState::Update(time_point tick)
{
    if (!IsCompleted() && tick > GetEntryTime() + 7000ms)
    {
        Complete();
        CMobEntity* mob = (CMobEntity*)m_PEntity;
        battleutils::DoClaimShieldLottery(mob);
        return true;
    }

    return false;
}

void CClaimShieldState::Cleanup(time_point tick)
{}
