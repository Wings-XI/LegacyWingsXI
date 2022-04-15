/*
===========================================================================

this entire document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
-Caelic

===========================================================================
*/

#ifndef _TARGETED_AVATAR_CONTROLLER_H
#define _TARGETED_AVATAR_CONTROLLER_H

#include "pet_controller.h"
#include "../../entities/petentity.h"
#include "../../status_effect.h"
#include "../../mobskill.h"
#include <optional>

class CTargetedAvatarController;

class CTargetedAvatarController : public CPetController
{
public:
    CTargetedAvatarController(CPetEntity* PPet, CBattleEntity* PTarget);

    virtual bool Engage(uint16 targid) override;
    virtual bool Disengage() override;
protected:
    virtual void DoRoamTick(time_point tick) override;
    virtual void DoCombatTick(time_point tick) override;
    virtual void Move() override;

private:
    bool TrySkill();
    bool TryAction();

    CPetEntity* PAvatar;
    CBattleEntity* PAbilityTarget;
    CMobSkill* PSkill;
    CMobSkill* PSkillSecondary;

    duration m_actionCooldown;
    duration m_skillCooldown;
    duration m_postLingerDuration;

    time_point m_LastActionTime;
    time_point m_LastSkillTime;
};

#endif
