/*
===========================================================================

this entire document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
Author: Caelic

===========================================================================
*/

#ifndef _SPIRITCONTROLLER_H
#define _SPIRITCONTROLLER_H

#include "pet_controller.h"
#include "../../entities/petentity.h"
#include "../../status_effect.h"
#include "../../spell.h"
#include <optional>

class CSpiritController;

class CSpiritController : public CPetController
{
public:
    CSpiritController(CPetEntity* PPet);

    virtual bool Engage(uint16 targid) override;
    virtual bool Disengage() override;
protected:
    virtual void DoRoamTick(time_point tick) override;
    virtual void DoCombatTick(time_point tick) override;
    virtual void Move() override;

    void setMagicCooldowns(bool initial);
    virtual bool CanCastSpells() override;

private:
    bool TryAction();
    bool TrySpellcast();
    bool TryIdleSpellcast();
    SpellID GetHighestNuke(uint32 pettype);
    SpellID GetDOT(uint32 pettype);
    SpellID GetAM(uint32 pettype);
    SpellID GetEnfeeble(uint32 pettype);
    SpellID GetHighestCure();
    SpellID GetBuff();
    int16 GetSummoningSkillOverCap();
    int8 WeatherFavorability();
    int8 DayFavorability();
    void LoadSpiritSpellList();

    CPetEntity* PSpirit;
    CBattleEntity* PCastTarget;

    duration m_actionCooldown;
    duration m_magicCooldown;

    time_point m_LastActionTime;
    time_point m_LastMagicTime;
};

#endif
