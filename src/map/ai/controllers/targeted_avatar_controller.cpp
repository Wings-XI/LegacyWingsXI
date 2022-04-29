/*
===========================================================================

this document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
-Caelic

===========================================================================
*/

#include "targeted_avatar_controller.h"
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
#include "../../utils/zoneutils.h"

CTargetedAvatarController::CTargetedAvatarController(CPetEntity* PPet, CBattleEntity* PTarget) : CPetController(PPet),
PAvatar(PPet), PAbilityTarget(PTarget)
{
    m_actionCooldown = 2s;
    m_LastActionTime = m_Tick - 20ms * tpzrand::GetRandomNumber(0, 50) - 1s; // initial AI tick cooldown 0s~1s

    m_skillCooldown = 7s;
    m_LastSkillTime = m_Tick - 3s; // initial skill cooldown 5s

    m_postLingerDuration = 5s;

    CCharEntity* PSummoner = nullptr;
    if (PAvatar->PMaster && PAvatar->PMaster->objtype == TYPE_PC)
        PSummoner = (CCharEntity*)(PAvatar->PMaster);
    if (PSummoner && PAbilityTarget->id == PSummoner->id)
        PAbilityTarget = (CBattleEntity*)PAvatar; // alexander spell is cast on summoner, but alexander targets himself not the cast target
    this->SetAutoAttackEnabled(false);
    PSkill = nullptr;
    PSkillSecondary = nullptr;
    uint32 id = PAvatar->m_PetID;

    if (id == PETID_ALEXANDER)
    {
        PSkill = battleutils::GetMobSkill(2143); //Perfect Defense
        ShowDebug("Alexander detected. Set PSkill to %i\n", PSkill->getID());
        m_LastSkillTime = m_Tick - 1s; // initial skill cooldown 5s
    }
    else if (id == PETID_ODIN)
    {
        PSkill = battleutils::GetMobSkill(2126); // Zantetsuken
        m_postLingerDuration = 7s;
        ShowDebug("Odin detected. Set PSkill to %i\n", PSkill->getID());
    }
    else if (id == PETID_ATOMOS)
    {
        PSkill = battleutils::GetMobSkill(2499); // Deconstruction
        ShowDebug("Atomos detected. Set PSkill to %i\n", PSkill->getID());
        PSkillSecondary = battleutils::GetMobSkill(2500); // Chronoshift
        ShowDebug("Atomos detected. Set PSkillSecondary to %i\n", PSkillSecondary->getID());
        m_LastSkillTime = m_Tick - 1s; // initial skill cooldown 5s
    }

}

void CTargetedAvatarController::DoRoamTick(time_point tick)
{
    if (PSkill == nullptr && PSkillSecondary == nullptr && m_Tick > m_LastSkillTime + m_postLingerDuration)
    {
        PAvatar->Die();
        return;
    }
    else if (TryAction() && TrySkill())
    {
        m_LastSkillTime = m_Tick;
        return;
    }
    else
    {
        CPetController::DoRoamTick(tick);
    }
}

void CTargetedAvatarController::DoCombatTick(time_point tick)
{
    if (PSkill == nullptr && PSkillSecondary == nullptr && m_Tick > m_LastSkillTime + m_postLingerDuration)
    {
        PAvatar->Die();
        return;
    }

    if ((PAvatar->PMaster == nullptr || PAvatar->PMaster->isDead()) && PAvatar->isAlive()) {
        PAvatar->Die();
        return;
    }

    if (TryAction() && TrySkill())
    {
        m_LastSkillTime = m_Tick;
        return;
    }

    PTarget = static_cast<CBattleEntity*>(PAvatar->GetEntity(PAvatar->GetBattleTargetID()));

    if (TryDeaggro())
    {
        Disengage();
        return;
    }

    // AI ticks are 2 seconds
    if (TryAction() && TrySkill())
    {
        return;
    }

    Move();
}

void CTargetedAvatarController::Move()
{
    float currentDistance = distanceSquared(PAvatar->loc.p, PTarget->loc.p);
    CPetController::Move();
}

bool CTargetedAvatarController::TrySkill()
{
    ShowDebug("Trying skill...\n");
    if (m_Tick < m_LastSkillTime + m_skillCooldown)
    {
        ShowDebug("...skill false1.\n");
        return false;
    }
    if (PSkill)
    {
        ShowDebug("Attempting PSKill id %i.\n", PSkill->getID());
        if (PAvatar->PAI->MobSkill((uint16)(PAbilityTarget->targid), PSkill->getID()) == false)
        {
            ShowDebug("PSkill was interrupted.\n");
            if (PSkillSecondary)
            {
                PSkillSecondary = nullptr;
            }
        }
        PSkill = nullptr;
        return true;
    }
    if (PSkillSecondary)
    {
        CCharEntity* PSummoner = nullptr;
        if (PAvatar->PMaster && PAvatar->PMaster->objtype == TYPE_PC)
            PSummoner = (CCharEntity*)(PAvatar->PMaster);

        if (PSummoner && PAvatar->GetLocalVar("ChronoshiftStatusID"))
        {
            ShowDebug("Attempting PSKillSecondary id %i.\n", PSkillSecondary->getID());
            PAvatar->PAI->MobSkill((uint16)(PSummoner->targid), PSkillSecondary->getID());
            PSkillSecondary = nullptr;
        }
        else
        {
            PSkillSecondary = nullptr;
        }
        return true;
    }
    ShowDebug("...skill false2.\n");
    return false;
}

bool CTargetedAvatarController::TryAction()
{
    if (m_Tick > m_LastActionTime + m_actionCooldown)
    {
        m_LastActionTime = m_Tick;
        return true;
    }
    return false;
}

bool CTargetedAvatarController::Engage(uint16 targid)
{
    if (PAvatar->m_PetID != PETID_ODIN || targid != PAbilityTarget->targid)
        return false;
    else
        return CMobController::Engage(targid);
}

bool CTargetedAvatarController::Disengage()
{
    PTarget = nullptr;
    return CMobController::Disengage();
}