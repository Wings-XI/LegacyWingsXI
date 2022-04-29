/*
===========================================================================

this document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.

===========================================================================
*/

#ifndef _CCLAIMSHIELD_STATE_H
#define _CCLAIMSHIELD_STATE_H

#include "state.h"

class CClaimShieldState : public CState
{
public:
    CClaimShieldState(CBaseEntity* PEntity);

protected:
    virtual bool CanChangeState() override { return false; }
    virtual bool CanFollowPath() override { return true; }
    virtual bool CanInterrupt() override { return false; }
    virtual bool Update(time_point tick) override;
    virtual void Cleanup(time_point tick) override;
};


#endif
