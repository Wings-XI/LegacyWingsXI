/*
===========================================================================

this document is part Wings FFXI server project.
(C) 2020-2021 Wings Project. Licensed under AGPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
The fishing system has been graciously contributed by Setz0r.

===========================================================================
*/

#ifndef _CFISHING_STATE_H
#define _CFISHING_STATE_H

#include "state.h"
#include "../../ability.h"

class CCharEntity;

class CFishingState : public CState
{
public:
    CFishingState(CCharEntity* PEntity);

protected:
    virtual bool CanChangeState() override { return false; }
    virtual bool CanFollowPath() override { return false; }
    virtual bool CanInterrupt() override { return false; }
    virtual bool Update(time_point tick) override;
    virtual void Cleanup(time_point tick) override {}

private:
    CCharEntity* const m_PEntity;
};


#endif
