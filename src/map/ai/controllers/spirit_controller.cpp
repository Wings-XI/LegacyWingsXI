/*
===========================================================================

this document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
Author: Caelic

===========================================================================
*/

#include "spirit_controller.h"
#include "../states/magic_state.h"
#include "../ai_container.h"
#include "../../utils/battleutils.h"
#include "../../lua/luautils.h"
#include "../../../common/utils.h"
#include "../../utils/petutils.h"
#include "../../status_effect_container.h"
#include "../../enmity_container.h"
#include "../../utils/itemutils.h"
#include "../../utils/battleutils.h"
#include "../../recast_container.h"
#include "../../mob_spell_list.h"
#include "../../mob_spell_container.h"
#include "../../utils/zoneutils.h"
#include "../../spell.h"

CSpiritController::CSpiritController(CPetEntity* PPet) : CPetController(PPet),
    PSpirit(PPet)
{;
    PCastTarget = nullptr;
    m_LastActionTime = m_Tick - 30ms * tpzrand::GetRandomNumber(0,100);
    LoadSpiritSpellList();
    setMagicCooldowns(true);
}

void CSpiritController::setMagicCooldowns(bool initial)
{
    CBattleEntity* PSummoner = PSpirit->PMaster;
    int16 mod = 0;
    bool buffMode = true;
    if (PSpirit->GetBattleTargetID() > 0 || initial)  // don't need to identify if it's a light spirit since only light spirits cast outside of combat
        buffMode = false;
    if (PSummoner && PSummoner->objtype == TYPE_PC)
        mod = PSummoner->getMod(Mod::SPIRIT_RECAST_REDUCTION);
    int8 day = DayFavorability();
    int8 weather = WeatherFavorability();
    int16 skill = GetSummoningSkillOverCap();
    bool AF = PSummoner && PSummoner->StatusEffectContainer->GetStatusEffect(EFFECT_ASTRAL_FLOW);

    m_magicCooldown = 45000ms - 333ms * skill - 1000ms * mod - 3000ms * day - 2000ms * weather - 5000ms * AF;
    if (buffMode)
        m_magicCooldown = m_magicCooldown / 2;
    m_actionCooldown = 3000ms - 25ms * skill;
    if (initial)
        m_LastMagicTime = m_Tick - m_magicCooldown + std::clamp<std::chrono::milliseconds>(13000ms * tpzrand::GetRandomNumber(75, 100) / 100 - 50ms * skill - 3000ms * day - 2000ms * weather - 333ms * mod - AF * 5000ms, 1500ms, 20000ms);
    // initial cooldown 9 to 12 seconds. actioncooldown is intervals of 2-3 sec so this can in reality be 9 to 15 seconds
    // +33 skill = approx -1 second on this initial cooldown ... AF -5 sec
    // day weather ... unfavorable = ~20 seconds ... neutral = ~15 seconds ... favorable = 10 seconds
}

void CSpiritController::DoRoamTick(time_point tick)
{
    if (TryAction() && TryIdleSpellcast())
    {
        setMagicCooldowns(false);
        return;
    }
    if (PSpirit->PAI->GetCurrentState() == nullptr || (PSpirit->PAI->GetCurrentState() && PSpirit->PAI->GetCurrentState()->m_id != MAGIC_STATE))
    {
        CPetController::DoRoamTick(tick);
    }
}

void CSpiritController::DoCombatTick(time_point tick)
{
    if ((PSpirit->PMaster == nullptr || PSpirit->PMaster->isDead()) && PSpirit->isAlive()) {
        PSpirit->Die();
        return;
    }

    PTarget = static_cast<CBattleEntity*>(PSpirit->GetEntity(PSpirit->GetBattleTargetID()));

    if (TryDeaggro())
    {
        Disengage();
        return;
    }

    // AI ticks are about 2-3 seconds depending on summoning skill
    if (TryAction() && TrySpellcast())
    {
        setMagicCooldowns(false);
        return;
    }

    Move();
}

void CSpiritController::Move()
{
    float currentDistance = distanceSquared(PSpirit->loc.p, PTarget->loc.p);
    CPetController::Move();
}

bool CSpiritController::TryAction()
{
    if (m_Tick > m_LastActionTime + m_actionCooldown)
    {
        m_LastActionTime = m_Tick;
        return true;
    }
    return false;
}

bool CSpiritController::TrySpellcast()
{
    if (!PSpirit->PMaster || m_Tick <= m_LastMagicTime + m_magicCooldown || !CanCastSpells())
        return false;

    SpellID spell = SpellID::NULLSPELL;
    uint32 petid = PSpirit->m_PetID;
    float skillbonus = (float)GetSummoningSkillOverCap();
    bool AF = PSpirit->PMaster && PSpirit->PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_ASTRAL_FLOW) && tpzrand::GetRandomNumber(0,2);
    PCastTarget = nullptr;

    switch (petid)
    {
    case PETID_EARTHSPIRIT:
    case PETID_WATERSPIRIT:
    case PETID_AIRSPIRIT:
    case PETID_FIRESPIRIT:
    case PETID_ICESPIRIT:
    case PETID_THUNDERSPIRIT:
        if (                               tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.20f                       - AF * 1.0f) { spell = GetEnfeeble(petid); }
        if (spell == SpellID::NULLSPELL && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.25f - 0.003f * skillbonus - AF * 1.0f) { spell = GetDOT(petid); }
        if (spell == SpellID::NULLSPELL && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.35f - 0.003f * skillbonus - AF * 1.0f) { spell = GetAM(petid); }
        if (spell == SpellID::NULLSPELL                                                                                  ) { spell = GetHighestNuke(petid); }
        break;
    case PETID_DARKSPIRIT:
        if (                               tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.25f + 0.002f * skillbonus + AF * 1.0f) { spell = GetEnfeeble(petid); } // sleep,sleep2,sleepga,sleepga2
        if (spell == SpellID::NULLSPELL && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.25f - 0.003f * skillbonus - AF * 1.0f) { spell = GetDOT(petid); } // bio,bio2
        if (spell == SpellID::NULLSPELL                                                                                  ) { spell = GetHighestNuke(petid); } // everything else
        break;
    case PETID_LIGHTSPIRIT:
        if (                                                                                                         true) { spell = GetHighestCure(); }
        if (spell == SpellID::NULLSPELL && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.50f                       - AF * 1.0f) { spell = GetDOT(petid); } // dia,dia2
        if (spell == SpellID::NULLSPELL && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.17f - 0.002f * skillbonus - AF * 1.0f) { spell = GetEnfeeble(petid); } // flash
        if (spell == SpellID::NULLSPELL && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.30f - 0.002f * skillbonus + AF * 1.0f) { spell = GetAM(petid); } // holy
        if (spell == SpellID::NULLSPELL                                                                                  ) { spell = GetHighestNuke(petid); } // banish1,2,3
        break;
    }

    if (spell > SpellID::Raise) // not a cure
        PCastTarget = PTarget; // target the battle target

    if (spell != SpellID::NULLSPELL && PCastTarget && Cast(PCastTarget->targid, spell))
    {
        m_LastMagicTime = m_Tick;
        return true;
    }

    return false;
}

bool CSpiritController::TryIdleSpellcast()
{
    if (PSpirit->m_PetID != PETID_LIGHTSPIRIT || !PSpirit->PMaster || m_Tick <= m_LastMagicTime + m_magicCooldown || !CanCastSpells())
        return false;

    PCastTarget = nullptr;
    SpellID spell = GetHighestCure();

    if (spell == SpellID::NULLSPELL)
        spell = GetBuff();

    if (spell != SpellID::NULLSPELL && PCastTarget && Cast(PCastTarget->targid, spell))
    {
        m_LastMagicTime = m_Tick;
        if (spell > SpellID::Curaga_V)
            m_LastMagicTime = m_Tick - m_magicCooldown / 2; // for buffs put it into the past, halfway into the cooldown already
        return true;
    }
    return false;
}

SpellID CSpiritController::GetHighestNuke(uint32 pettype)
{
    uint8 level = PSpirit->GetMLevel();

    switch (pettype)
    {
    case PETID_EARTHSPIRIT:
        if (level > 25 && level < 51)
            return SpellID::Stone_II;
        if (level > 50 && level < 68)
            return SpellID::Stone_III;
        if (level > 67)
            return SpellID::Stone_IV;
        return SpellID::Stone;
        break;
    case PETID_WATERSPIRIT:
        if (level > 4 && level < 30)
            return SpellID::Water;
        if (level > 29 && level < 55)
            return SpellID::Water_II;
        if (level > 54 && level < 70)
            return SpellID::Water_III;
        if (level > 69)
            return SpellID::Water_IV;
        break;
    case PETID_AIRSPIRIT:
        if (level > 8 && level < 34)
            return SpellID::Aero;
        if (level > 33 && level < 59)
            return SpellID::Aero_II;
        if (level > 58 && level < 72)
            return SpellID::Aero_III;
        if (level > 71)
            return SpellID::Aero_IV;
        break;
    case PETID_FIRESPIRIT:
        if (level > 12 && level < 38)
            return SpellID::Fire;
        if (level > 37 && level < 62)
            return SpellID::Fire_II;
        if (level > 61 && level < 73)
            return SpellID::Fire_III;
        if (level > 72)
            return SpellID::Fire_IV;
        break;
    case PETID_ICESPIRIT:
        if (level > 16 && level < 42)
            return SpellID::Blizzard;
        if (level > 41 && level < 64)
            return SpellID::Blizzard_II;
        if (level > 63 && level < 74)
            return SpellID::Blizzard_III;
        if (level > 73)
            return SpellID::Blizzard_IV;
        break;
    case PETID_THUNDERSPIRIT:
        if (level > 20 && level < 46)
            return SpellID::Thunder;
        if (level > 45 && level < 66)
            return SpellID::Thunder_II;
        if (level > 65 && level < 75)
            return SpellID::Thunder_III;
        if (level > 74)
            return SpellID::Thunder_IV;
        break;
    case PETID_DARKSPIRIT: // not nukes but the rest of the spells were put here
        if (level > 19 && PSpirit->GetMPP() < 15)
            return SpellID::Aspir;
        if (level > 9 && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.33f)
            return SpellID::Drain;
        if (level > 36 && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.33f)
            return SpellID::Stun;
        if (level > 31 && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.33f)
            return SpellID::Dispel;
        if (level > 19 && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.25f)
            return SpellID::Aspir;
        if (level > 38 && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.45f)
            return SpellID::Absorb_INT;
        if (level > 42 && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.2f)
            return (SpellID)(266 + tpzrand::GetRandomNumber(0, 6));
        if (level > 19 && PSpirit->GetMPP() < 40)
            return SpellID::Aspir;
        if (level > 9)
            return SpellID::Drain;
        break;
    case PETID_LIGHTSPIRIT:
        if (level > 4 && level < 30)
            return SpellID::Banish;
        if (level > 29 && level < 65)
            return SpellID::Banish_II;
        if (level > 64)
            return SpellID::Banish_III;
        break;
    }

    return SpellID::NULLSPELL;
}

SpellID CSpiritController::GetDOT(uint32 pettype)
{
    uint8 level = PSpirit->GetMLevel();

    switch (pettype)
    {
    case PETID_EARTHSPIRIT:
        if (level > 17)
            return SpellID::Rasp;
        break;
    case PETID_WATERSPIRIT:
        if (level > 26)
            return SpellID::Drown;
        break;
    case PETID_AIRSPIRIT:
        if (level > 19)
            return SpellID::Choke;
        break;
    case PETID_FIRESPIRIT:
        if (level > 23)
            return SpellID::Burn;
        break;
    case PETID_ICESPIRIT:
        if (level > 21)
            return SpellID::Frost;
        break;
    case PETID_THUNDERSPIRIT:
        if (level > 15)
            return SpellID::Shock;
        break;
    case PETID_DARKSPIRIT:
        if (level > 9 && level < 35)
            return SpellID::Bio;
        if (level > 34)
            return SpellID::Bio_II;
        break;
    case PETID_LIGHTSPIRIT:
        if (level > 30)
            return SpellID::Dia_II;
        else
            return SpellID::Dia;
        break;
    }

    return SpellID::NULLSPELL;
}

SpellID CSpiritController::GetAM(uint32 pettype)
{
    uint8 level = PSpirit->GetMLevel();

    switch (pettype)
    {
    case PETID_EARTHSPIRIT:
        if (level > 53)
            return SpellID::Quake;
        break;
    case PETID_WATERSPIRIT:
        if (level > 57)
            return SpellID::Flood;
        break;
    case PETID_AIRSPIRIT:
        if (level > 51)
            return SpellID::Tornado;
        break;
    case PETID_FIRESPIRIT:
        if (level > 59)
            return SpellID::Flare;
        break;
    case PETID_ICESPIRIT:
        if (level > 49)
            return SpellID::Freeze;
        break;
    case PETID_THUNDERSPIRIT:
        if (level > 55)
            return SpellID::Burst;
        break;
    case PETID_DARKSPIRIT:
        break;
    case PETID_LIGHTSPIRIT:
        if (level > 49)
            return SpellID::Holy;
        break;
    }

    return SpellID::NULLSPELL;
}

SpellID CSpiritController::GetEnfeeble(uint32 pettype)
{
    uint8 level = PSpirit->GetMLevel();
    SpellID ret = SpellID::NULLSPELL;
    switch (pettype)
    {
    case PETID_EARTHSPIRIT:
        if (level > 12)
            return SpellID::Slow;
        break;
    case PETID_WATERSPIRIT:
        if (level > 2 && level < 42)
            return SpellID::Poison;
        if (level > 41)
            return SpellID::Poison_II;
        break;
    case PETID_AIRSPIRIT:
        if (level > 14 && level < 21)
            return SpellID::Silence;
        if (level > 20 && tpzrand::GetRandomNumber(0, 1))
            return SpellID::Silence;
        else if (level > 20)
            return SpellID::Gravity;
        break;
    case PETID_FIRESPIRIT:
        break;
    case PETID_ICESPIRIT:
        if (level > 3 && level < 7)
            return SpellID::Paralyze;
        if (level > 6 && tpzrand::GetRandomNumber(0, 1))
            return SpellID::Paralyze;
        else if (level > 6)
            return SpellID::Bind;
        break;
    case PETID_THUNDERSPIRIT:
        break;
    case PETID_DARKSPIRIT:
        if (level > 30 && level < 56)
            ret = SpellID::Sleepga; // neither sleepga is working at the moment. can't figure out why. it just never casts either one.
        else if (level > 55 && tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.45f)
            ret = SpellID::Sleepga;
        else if (level > 55)
            ret = SpellID::Sleepga_II;
        if (level < 31 || tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.4f)
        {
            if (level > 19 && level < 41)
                return SpellID::Sleep;
            if (level > 40)
                return SpellID::Sleep_II;
        }
        break;
    case PETID_LIGHTSPIRIT:
        if (level > 36)
            return SpellID::Flash;
        break;
    }

    return ret;
}

SpellID CSpiritController::GetHighestCure()
{
    CBattleEntity* party[18] = { };
    PCastTarget = nullptr;
    SpellID cure = SpellID::NULLSPELL;
    CBattleEntity* PSummoner = PSpirit->PMaster;
    CBattleEntity* PSummon = PSpirit;
    uint8 level = PSpirit->GetMLevel();
    if (level > 60)
        cure = SpellID::Cure_V;
    else if (level > 40)
        cure = SpellID::Cure_IV;
    else if (level > 20)
        cure = SpellID::Cure_III;
    else if (level > 10)
        cure = SpellID::Cure_II;
    else
        cure = SpellID::Cure;
    if (tpzrand::GetRandomNumber(0.0f, 1.0f) < 0.6f) // prefer curagas, even on a party of one
    {
        if (level > 70)
            cure = SpellID::Curaga_IV;
        else if (level > 50)
            cure = SpellID::Curaga_III;
        else if (level > 30)
            cure = SpellID::Curaga_II;
        else if (level > 15)
            cure = SpellID::Curaga;
    }

    if (cure != SpellID::NULLSPELL)
    {
        uint8 i = 0;
        PSummoner->ForAlliance([PSummon, &party, cure, &i](CBattleEntity* PMember)
            {
                if (PMember->isAlive() && !PMember->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE) && PMember->GetHPP() < 75 && PMember->getZone() == PSummon->getZone() && distance(PSummon->loc.p, PMember->loc.p) < (spell::GetSpell(cure))->getRange())
                {
                    party[i] = PMember;
                    i++;
                }
            });
        if (i > 0)
        {
            if (i == 1)
                PCastTarget = party[0];
            else
                PCastTarget = party[tpzrand::GetRandomNumber(0, i - 1)];
        }
    }

    if (PCastTarget)
        return cure;

    return SpellID::NULLSPELL;
}

SpellID CSpiritController::GetBuff()
{
    CBattleEntity* party[6] = { };
    PCastTarget = nullptr;
    CBattleEntity* PCandidate = nullptr;
    SpellID buff = SpellID::NULLSPELL;
    CBattleEntity* PSummoner = PSpirit->PMaster;
    CBattleEntity* PSummon = PSpirit;
    uint8 level = PSpirit->GetMLevel();
    if (level < 7)
        return SpellID::NULLSPELL;

    SpellID highestRegen = SpellID::NULLSPELL;
    SpellID highestHaste = SpellID::NULLSPELL;
    SpellID highestProtect = SpellID::NULLSPELL;
    SpellID highestShell = SpellID::NULLSPELL;

    if (level > 20)
        highestRegen = SpellID::Regen;
    if (level > 39)
        highestHaste = SpellID::Haste;
    if (level > 62)
        highestProtect = SpellID::Protect_IV;
    else if (level > 46)
        highestProtect = SpellID::Protect_III;
    else if (level > 26)
        highestProtect = SpellID::Protect_II;
    else if (level > 6)
        highestProtect = SpellID::Protect;
    if (level > 67)
        highestShell = SpellID::Shell_IV;
    else if (level > 56)
        highestShell = SpellID::Shell_III;
    else if (level > 36)
        highestShell = SpellID::Shell_II;
    else if (level > 16)
        highestShell = SpellID::Shell;

    uint8 i = 0;
    PSummoner->ForParty([PSummon, &party, &i](CBattleEntity* PMember)
        {
            if (PMember->isAlive() && !PMember->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE) && PMember->getZone() == PSummon->getZone() && distance(PSummon->loc.p, PMember->loc.p) < (spell::GetSpell(SpellID::Protect))->getRange())
            {
                party[i] = PMember;
                i++;
            }
        });
    if (i > 0)
    {
        uint8 j = tpzrand::GetRandomNumber(0, i - 1);
        uint8 k = 0;
        while (k < i && buff == SpellID::NULLSPELL)
        {
            PCandidate = party[j];

            if (highestProtect != SpellID::NULLSPELL && !(PCandidate->StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT)))
                buff = highestProtect;
            else if (highestShell != SpellID::NULLSPELL && !(PCandidate->StatusEffectContainer->HasStatusEffect(EFFECT_SHELL)))
                buff = highestShell;
            else if (highestHaste != SpellID::NULLSPELL && !(PCandidate->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE)))
                buff = highestHaste;
            else if (highestRegen != SpellID::NULLSPELL && !(PCandidate->StatusEffectContainer->HasStatusEffect(EFFECT_REGEN)))
                buff = highestRegen;

            j++;
            if (j > i - 1)
                j = 0;
            k++;
        }
    }

    if (buff != SpellID::NULLSPELL)
    {
        PCastTarget = PCandidate;
        return buff;
    }

    return SpellID::NULLSPELL;
}

bool CSpiritController::CanCastSpells()
{
    if (PSpirit->StatusEffectContainer->HasStatusEffect({ EFFECT_SILENCE, EFFECT_MUTE }))
        return false;

    return PSpirit->PAI->CanChangeState();
}

bool CSpiritController::Engage(uint16 targid)
{
    m_LastActionTime = m_Tick - m_actionCooldown + 250ms; // restart the AI tick timer
    return CMobController::Engage(targid);
}

bool CSpiritController::Disengage()
{
    PTarget = nullptr;
    return CMobController::Disengage();
}

int16 CSpiritController::GetSummoningSkillOverCap()
{
    uint16 ret = 0;
    CBattleEntity* PSummoner = PSpirit->PMaster;

    if (PSummoner && PSummoner->objtype == TYPE_PC)
    {
        uint8 joblevel = 1;
        if (PSummoner->GetMJob() == JOB_SMN)
            joblevel = PSummoner->GetMLevel();
        else if (PSummoner->GetSJob() == JOB_SMN)
            joblevel = PSummoner->GetSLevel();

        uint16 currskill = PSummoner->GetSkill(SKILL_SUMMONING_MAGIC);
        uint16 maxskill = battleutils::GetMaxSkill(SKILL_SUMMONING_MAGIC, JOB_SMN, joblevel);

        ret = currskill - maxskill;

        if (ret < -30)
            ret = -30;
    }

    return ret;
}

int8 CSpiritController::WeatherFavorability()
{
    WEATHER cweather = WEATHER_NONE;
    CBattleEntity* PSummoner = PSpirit->PMaster;

    if (PSummoner == nullptr)
        return 0;
    if (PSummoner->objtype == TYPE_PC)
        cweather = battleutils::GetWeather(PSummoner, false);
    else
        cweather = zoneutils::GetZone(PSummoner->getZone())->GetWeather();

    switch (PSpirit->m_PetID)
    {
    case PETID_EARTHSPIRIT:
        if (cweather == WEATHER_DUST_STORM || cweather == WEATHER_SAND_STORM)
            return 1;
        if (cweather == WEATHER_WIND || cweather == WEATHER_GALES)
            return -1;
        break;
    case PETID_WATERSPIRIT:
        if (cweather == WEATHER_RAIN || cweather == WEATHER_SQUALL)
            return 1;
        if (cweather == WEATHER_THUNDER || cweather == WEATHER_THUNDERSTORMS)
            return -1;
        break;
    case PETID_AIRSPIRIT:
        if (cweather == WEATHER_WIND || cweather == WEATHER_GALES)
            return 1;
        if (cweather == WEATHER_SNOW || cweather == WEATHER_BLIZZARDS)
            return -1;
        break;
    case PETID_FIRESPIRIT:
        if (cweather == WEATHER_HOT_SPELL || cweather == WEATHER_HEAT_WAVE)
            return 1;
        if (cweather == WEATHER_RAIN || cweather == WEATHER_SQUALL)
            return -1;
        break;
    case PETID_ICESPIRIT:
        if (cweather == WEATHER_SNOW || cweather == WEATHER_BLIZZARDS)
            return 1;
        if (cweather == WEATHER_HOT_SPELL || cweather == WEATHER_HEAT_WAVE)
            return -1;
        break;
    case PETID_THUNDERSPIRIT:
        if (cweather == WEATHER_THUNDER || cweather == WEATHER_THUNDERSTORMS)
            return 1;
        if (cweather == WEATHER_DUST_STORM || cweather == WEATHER_SAND_STORM)
            return -1;
        break;
    case PETID_DARKSPIRIT:
        if (cweather == WEATHER_GLOOM || cweather == WEATHER_DARKNESS)
            return 1;
        if (cweather == WEATHER_AURORAS || cweather == WEATHER_STELLAR_GLARE)
            return -1;
        break;
    case PETID_LIGHTSPIRIT:
        if (cweather == WEATHER_AURORAS || cweather == WEATHER_STELLAR_GLARE)
            return 1;
        if (cweather == WEATHER_GLOOM || cweather == WEATHER_DARKNESS)
            return -1;
        break;
    }

    return 0;

}

int8 CSpiritController::DayFavorability()
{
    uint32 day = CVanaTime::getInstance()->getWeekday();

    switch (PSpirit->m_PetID)
    {
    case PETID_EARTHSPIRIT:
        if (day == DAYTYPE::EARTHSDAY)
            return 1;
        if (day == DAYTYPE::WINDSDAY)
            return -1;
        break;
    case PETID_WATERSPIRIT:
        if (day == DAYTYPE::WATERSDAY)
            return 1;
        if (day == DAYTYPE::LIGHTNINGDAY)
            return -1;
        break;
    case PETID_AIRSPIRIT:
        if (day == DAYTYPE::WINDSDAY)
            return 1;
        if (day == DAYTYPE::ICEDAY)
            return -1;
        break;
    case PETID_FIRESPIRIT:
        if (day == DAYTYPE::FIRESDAY)
            return 1;
        if (day == DAYTYPE::WATERSDAY)
            return -1;
        break;
    case PETID_ICESPIRIT:
        if (day == DAYTYPE::ICEDAY)
            return 1;
        if (day == DAYTYPE::FIRESDAY)
            return -1;
        break;
    case PETID_THUNDERSPIRIT:
        if (day == DAYTYPE::LIGHTNINGDAY)
            return 1;
        if (day == DAYTYPE::EARTHSDAY)
            return -1;
        break;
    case PETID_DARKSPIRIT:
        if (day == DAYTYPE::DARKSDAY)
            return 1;
        if (day == DAYTYPE::LIGHTSDAY)
            return -1;
        break;
    case PETID_LIGHTSPIRIT:
        if (day == DAYTYPE::LIGHTSDAY)
            return 1;
        if (day == DAYTYPE::DARKSDAY)
            return -1;
        break;
    }

    return 0;
}

void CSpiritController::LoadSpiritSpellList()
{
    CMobSpellContainer* spellList = PSpirit->SpellContainer;
    uint16 level = PSpirit->GetMLevel();
    switch (PSpirit->m_PetID)
    {
    case PETID_EARTHSPIRIT:
        //spellList->AddSpell(SpellID::Stone, 1, 25);
        //spellList->AddSpell(SpellID::Stone_II, 26, 50);
        //spellList->AddSpell(SpellID::Stone_III, 51, 67);
        //spellList->AddSpell(SpellID::Stone_IV, 68, 99);
        //spellList->AddSpell(SpellID::Quake, 54, 99);
        //spellList->AddSpell(SpellID::Rasp, 18, 99);
        //spellList->AddSpell(SpellID::Slow, 13, 99);
        break;
    case PETID_WATERSPIRIT:
        //spellList->AddSpell(SpellID::Water, 5, 29);
        //spellList->AddSpell(SpellID::Water_II, 30, 54);
        //spellList->AddSpell(SpellID::Water_III, 55, 69);
        //spellList->AddSpell(SpellID::Water_IV, 70, 99);
        //spellList->AddSpell(SpellID::Flood, 58, 99);
        //spellList->AddSpell(SpellID::Drown, 27, 99);
        //spellList->AddSpell(SpellID::Poison, 3, 41);
        //spellList->AddSpell(SpellID::Poison_II, 42, 99);
        break;
    case PETID_AIRSPIRIT:
        //spellList->AddSpell(SpellID::Aero, 9, 33);
        //spellList->AddSpell(SpellID::Aero_II, 34, 58);
        //spellList->AddSpell(SpellID::Aero_III, 59, 71);
        //spellList->AddSpell(SpellID::Aero_IV, 72, 99);
        //spellList->AddSpell(SpellID::Tornado, 52, 99);
        //spellList->AddSpell(SpellID::Choke, 20, 99);
        //spellList->AddSpell(SpellID::Silence, 15, 99);
        //spellList->AddSpell(SpellID::Gravity, 21, 99);
        break;
    case PETID_FIRESPIRIT:
        //spellList->AddSpell(SpellID::Fire, 13, 37);
        //spellList->AddSpell(SpellID::Fire_II, 38, 61);
        //spellList->AddSpell(SpellID::Fire_III, 62, 72);
        //spellList->AddSpell(SpellID::Fire_IV, 73, 99);
        //spellList->AddSpell(SpellID::Flare, 60, 99);
        //spellList->AddSpell(SpellID::Burn, 24, 99);
        break;
    case PETID_ICESPIRIT:
        //spellList->AddSpell(SpellID::Blizzard, 17, 41);
        //spellList->AddSpell(SpellID::Blizzard_II, 42, 63);
        //spellList->AddSpell(SpellID::Blizzard_III, 64, 73);
        //spellList->AddSpell(SpellID::Blizzard_IV, 74, 99);
        //spellList->AddSpell(SpellID::Freeze, 50, 99);
        //spellList->AddSpell(SpellID::Frost, 22, 99);
        //spellList->AddSpell(SpellID::Paralyze, 4, 99);
        //spellList->AddSpell(SpellID::Bind, 7, 99);
        break;
    case PETID_THUNDERSPIRIT:
        //spellList->AddSpell(SpellID::Thunder, 21, 45);
        //spellList->AddSpell(SpellID::Thunder_II, 46, 65);
        //spellList->AddSpell(SpellID::Thunder_III, 66, 74);
        //spellList->AddSpell(SpellID::Thunder_IV, 75, 99);
        //spellList->AddSpell(SpellID::Burst, 56, 99);
        //spellList->AddSpell(SpellID::Shock, 16, 99);
        break;
    case PETID_DARKSPIRIT:
        if (level > 30)
            spellList->AddSpell(SpellID::Sleepga);
        if (level > 55)
            spellList->AddSpell(SpellID::Sleepga_II);
        //spellList->AddSpell(SpellID::Sleep, 20, 40);
        //spellList->AddSpell(SpellID::Sleep_II, 41, 99);
        //spellList->AddSpell(SpellID::Drain, 10, 99);
        //spellList->AddSpell(SpellID::Aspir, 20, 99);
        //spellList->AddSpell(SpellID::Bio, 10, 99);
        //spellList->AddSpell(SpellID::Bio_II, 35, 99);
        //spellList->AddSpell(SpellID::Stun, 37, 99);
        //spellList->AddSpell(SpellID::Dispel, 32, 99);
        //spellList->AddSpell(SpellID::Absorb_MND, 31, 99);
        //spellList->AddSpell(SpellID::Absorb_CHR, 33, 99);
        //spellList->AddSpell(SpellID::Absorb_VIT, 35, 99);
        //spellList->AddSpell(SpellID::Absorb_AGI, 37, 99);
        //spellList->AddSpell(SpellID::Absorb_INT, 39, 99);
        //spellList->AddSpell(SpellID::Absorb_DEX, 41, 99);
        //spellList->AddSpell(SpellID::Absorb_STR, 43, 99);
        break;
    case PETID_LIGHTSPIRIT:
        //spellList->AddSpell(SpellID::Cure, 1, 10);
        //spellList->AddSpell(SpellID::Cure_II, 11, 20);
        //spellList->AddSpell(SpellID::Cure_III, 21, 40);
        //spellList->AddSpell(SpellID::Cure_IV, 41, 60);
        //spellList->AddSpell(SpellID::Cure_V, 61, 99);
        //spellList->AddSpell(SpellID::Curaga, 16, 31);
        //spellList->AddSpell(SpellID::Curaga_II, 32, 50);
        //spellList->AddSpell(SpellID::Curaga_III, 51, 70);
        //spellList->AddSpell(SpellID::Curaga_IV, 71, 99);
        //spellList->AddSpell(SpellID::Protect, 7, 26);
        //spellList->AddSpell(SpellID::Protect_II, 27, 46);
        //spellList->AddSpell(SpellID::Protect_III, 47, 62);
        //spellList->AddSpell(SpellID::Protect_IV, 63, 99);
        //spellList->AddSpell(SpellID::Shell, 17, 36);
        //spellList->AddSpell(SpellID::Shell_II, 37, 56);
        //spellList->AddSpell(SpellID::Shell_III, 57, 67);
        //spellList->AddSpell(SpellID::Shell_IV, 68, 99);
        //spellList->AddSpell(SpellID::Regen, 21, 99);
        //spellList->AddSpell(SpellID::Haste, 40, 99);
        //spellList->AddSpell(SpellID::Banish, 5, 29);
        //spellList->AddSpell(SpellID::Banish_II, 30, 64);
        //spellList->AddSpell(SpellID::Banish_III, 65, 99);
        //spellList->AddSpell(SpellID::Holy, 50, 99);
        //spellList->AddSpell(SpellID::Dia, 1, 30);
        //spellList->AddSpell(SpellID::Dia_II, 31, 99);
        //spellList->AddSpell(SpellID::Flash, 37, 99);
        break;
    }
    return;
}
