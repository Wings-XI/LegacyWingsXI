/*
===========================================================================

this document is part Wings FFXI server project.
(C) 2020-2021 Wings Project. Licensed under AGPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
The fishing system has been graciously contributed by Setz0r.

===========================================================================
*/

#include "../ai_container.h"
#include "../../entities/charentity.h"
#include "../../packets/action.h"
#include "fishing_state.h"

CFishingState::CFishingState(CCharEntity* PChar) :
    CState(PChar, PChar->targid),
    m_PEntity(PChar)
{

}

bool CFishingState::Update(time_point tick)
{
    if (!IsCompleted() && tick > GetEntryTime() + 1500ms)
    {
        Complete();
        m_PEntity->animation = ANIMATION_NONE;
        m_PEntity->updatemask |= UPDATE_HP;
        return true;
    }

    return false;
}

