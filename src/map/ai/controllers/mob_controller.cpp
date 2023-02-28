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

// REVERTED NAVMESH CHANGES FROM TOPAZ AFTER ISSUES

#include "mob_controller.h"
#include "../ai_container.h"
#include "../helpers/targetfind.h"
#include "../states/ability_state.h"
#include "../states/inactive_state.h"
#include "../states/magic_state.h"
#include "../states/weaponskill_state.h"
#include "../states/claimshield_state.h"
#include "../../mobskill.h"
#include "../../party.h"
#include "../../status_effect_container.h"
#include "../../enmity_container.h"
#include "../../mob_modifier.h"
#include "../../mob_spell_container.h"
#include "../../entities/mobentity.h"
#include "../../utils/battleutils.h"
#include "../../../common/utils.h"
#include "../../utils/petutils.h"
#include "../../utils/zoneutils.h"

#define TRY_LINK_TICK_FREQUENCY 4

CMobController::CMobController(CMobEntity* PEntity) :
    CController(PEntity),
    PMob(PEntity),
    m_forceDeaggroAll(false)
{}

void CMobController::Tick(time_point tick)
{
    TracyZoneScoped;
    TracyZoneIString(PMob->GetName());

    m_Tick = tick;

    if (PMob->isAlive())
    {
        if (PMob->PAI->IsEngaged())
        {
            DoCombatTick(tick);
        }
        else if (!PMob->isDead())
        {
            DoRoamTick(tick);
        }
    }
}

bool CMobController::TryDeaggro()
{
    TracyZoneScoped;
    if (PTarget == nullptr && (PMob->PEnmityContainer != nullptr && PMob->PEnmityContainer->GetHighestEnmity() == nullptr))
    {
        m_forcedDeaggroEntities.clear();
        m_forceDeaggroAll = false;
        return true;
    }

    bool isForcedDeaggro = (std::find(m_forcedDeaggroEntities.begin(), m_forcedDeaggroEntities.end(), PTarget) != m_forcedDeaggroEntities.end());
    // target is no longer valid, so wipe them from our enmity list
    if (!PTarget || PTarget->isDead() ||
        PTarget->isMounted() ||
        PTarget->loc.zone->GetID() != PMob->loc.zone->GetID() ||
        PMob->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        PMob->allegiance == PTarget->allegiance ||
        CheckDetection(PTarget) ||
        CheckHide(PTarget) ||
        isForcedDeaggro ||
        m_forceDeaggroAll)
    {
        if (PTarget) PMob->PEnmityContainer->Clear(PTarget->id);
        PTarget = PMob->PEnmityContainer->GetHighestEnmity();
        PMob->SetBattleTargetID(PTarget ? PTarget->targid : 0);
        return TryDeaggro();
    }

    m_forcedDeaggroEntities.clear();
    m_forceDeaggroAll = false;
    return false;
}

bool CMobController::CanPursueTarget(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (PMob->m_Detects & DETECT_SCENT)
    {
        // if mob is in water it will instant deaggro if target cannot be detected
        if (!PMob->PAI->PathFind->InWater() && !PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DEODORIZE))
        {
            // certain weather / deodorize will turn on time deaggro
            return PMob->m_disableScent;
        }
    }
    return false;
}

bool CMobController::CheckHide(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (PTarget->GetMJob() == JOB_THF && PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))
    {
        return !CanPursueTarget(PTarget) && !PMob->m_TrueDetection;
    }
    return false;
}

bool CMobController::CheckDetection(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    if (CanDetectTarget(PTarget) || CanPursueTarget(PTarget) ||
        PMob->StatusEffectContainer->HasStatusEffect({EFFECT_BIND, EFFECT_SLEEP, EFFECT_SLEEP_II, EFFECT_LULLABY}))
    {
        TapDeaggroTime();
    }

    return PMob->CanDeaggro() && (m_Tick >= m_DeaggroTime + 25s);
}

void CMobController::TryLink()
{
    // only try links if engaged and every few server ticks
    if (PTarget == nullptr || ++m_TryLinkSkippedTicks < TRY_LINK_TICK_FREQUENCY)
    {
        return;
    }
    TracyZoneScoped;

    m_TryLinkSkippedTicks = 0;

    //handle pet behaviour on the targets behalf (faster than in ai_pet_dummy)
    // Avatars defend masters by attacking mobs if the avatar isn't attacking anything currently (bodyguard behaviour)
    if (PTarget->PPet != nullptr && PTarget->PPet->GetBattleTargetID() == 0)
    {
        if (PTarget->PPet->objtype == TYPE_PET && ((CPetEntity*)PTarget->PPet)->getPetType() == PETTYPE_AVATAR)
        {
            if (PTarget->objtype == TYPE_PC)
            {
                if (!((CCharEntity*)PTarget)->IsMobOwner(PMob))
                {
                    return;
                }
            }

            petutils::AttackTarget(PTarget, PMob);
        }
    }

    // my pet should help as well
    if (PMob->PPet != nullptr && PMob->PPet->PAI->IsRoaming())
    {
        ((CMobEntity*)PMob->PPet)->PEnmityContainer->AddBaseEnmity(PTarget);
    }

    // Handle monster linking if they are close enough
    if (PMob->PParty != nullptr)
    {
        for (uint16 i = 0; i < PMob->PParty->members.size(); ++i)
        {
            CMobEntity* PPartyMember = (CMobEntity*)PMob->PParty->members[i];

            if (PPartyMember->PAI->IsRoaming() && PPartyMember->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
            {
                PPartyMember->PEnmityContainer->AddBaseEnmity(PTarget);

                if (PPartyMember->m_roamFlags & ROAMFLAG_IGNORE)
                {
                    // force into attack action
                    //#TODO
                    PPartyMember->PAI->Engage(PTarget->targid);
                }
            }
        }
    }

    // WINGSCUSTOM - Pixies who can heal player characters superlink with others of the same family (if the player aggros pixies due to personal pixie hate)
    // family linking with NM or Pixie superlinking
    if (PMob->getMobMod(MOBMOD_ATTRACT_FAMILY_NM) || PMob->getMobMod(MOBMOD_PIXIE))
    {
        uint16 family = PMob->m_Family;
        position_t locp = PMob->loc.p;
        int16 superlink = PMob->getMobMod(MOBMOD_SUPERLINK);
        CBattleEntity* PTarg = PTarget;
        zoneutils::GetZone(PMob->getZone())->ForEachMob([&family, &locp, &superlink, &PTarg](CMobEntity* Pnm)
            {
                CCharEntity* PChar = nullptr;
                if (PTarg->PMaster != nullptr)
                {
                    PChar = static_cast<CCharEntity*>(PTarg->PMaster);
                }
                else if (PTarg->objtype == TYPE_PC){
                    PChar = static_cast<CCharEntity*>(PTarg);
                }
            if ((Pnm->m_Type & MOBTYPE_NOTORIOUS ||
                    Pnm->getMobMod(MOBMOD_PIXIE)) &&
                Pnm->m_Family == family && Pnm->PAI->IsRoaming() &&
                (Pnm->CanLink(&locp, superlink) ||
                    (Pnm->getMobMod(MOBMOD_PIXIE) && PChar != nullptr && PChar->m_pixieHate >= Pnm->PixieGetHealHateThreshold(PChar)))) // WINGSCUSTOM - superlink for pixies (only superlink if player has enough pixie hate to not get cures)
            {
                Pnm->PEnmityContainer->AddBaseEnmity(PTarg);

                if (Pnm->m_roamFlags & ROAMFLAG_IGNORE)
                {
                    Pnm->PAI->Engage(PTarg->targid);
                }
            }
            });

    }

    // ask my master for help
    if (PMob->PMaster != nullptr && PMob->PMaster->PAI->IsRoaming())
    {
        CMobEntity* PMaster = (CMobEntity*)PMob->PMaster;

        if (PMaster->PAI->IsRoaming() && PMaster->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
        {
            PMaster->PEnmityContainer->AddBaseEnmity(PTarget);
        }
    }
}

/**
* Checks if the mob can detect the target using it's detection (sight, sound, etc)
* This is used to aggro and deaggro (Mobs start to deaggro after failing to detect target).
**/
bool CMobController::CanDetectTarget(CBattleEntity* PTarget, bool forceSight, bool detectDead)
{
    TracyZoneScoped;
    if ((!detectDead) && (PTarget->isDead() || PTarget->isMounted())) return false;

    float verticalDistance = abs(PMob->loc.p.y - PTarget->loc.p.y);

    if (PMob->m_Family != 6 && verticalDistance > 8.0f)
    {
        return false;   
    }

    if (PTarget->loc.zone->HasReducedVerticalAggro() && verticalDistance > 3.5f)
    {
        return false;
    }

    auto detects = PMob->m_Detects;
    auto currentDistance = distance(PTarget->loc.p, PMob->loc.p) + PTarget->getMod(Mod::STEALTH);

    bool detectSight = (detects & DETECT_SIGHT) || forceSight;
    bool hasInvisible = false;
    bool hasSneak = false;
    if (PMob->m_TrueDetection == 0) // No True Detection
    { 
        hasSneak = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK); // Does not ignore sneak.
        hasInvisible = PTarget->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE); // Does not ignore invisible.
    }
    if (PMob->m_TrueDetection == 1) // True Sight and Hearing
    { 
        // Ignores Invisible and Sneak
    }
    if (PMob->m_TrueDetection == 2) // True Sight
    { 
        hasSneak = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK); // Does not ignore sneak.
    }
    if (PMob->m_TrueDetection == 3) // True Hearing
    { 
        hasInvisible = PTarget->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE); // Does not ignore invisible.
    }

    auto angle = PMob->getMobMod(MOBMOD_SIGHT_ANGLE);
    if (angle == 0)
    {
        angle = 64;
    }

    if (detectSight && !hasInvisible && currentDistance < PMob->getMobMod(MOBMOD_SIGHT_RANGE) && facing(PMob->loc.p, PTarget->loc.p, angle))
    {
        return CanSeePoint(PTarget->loc.p);
    }

    if ((PMob->m_Behaviour & BEHAVIOUR_AGGRO_AMBUSH) && currentDistance < 3 && !hasSneak)
    {
        return true;
    }

    if ((detects & DETECT_HEARING) && currentDistance < PMob->getMobMod(MOBMOD_SOUND_RANGE) && !hasSneak)
    {
        return CanSeePoint(PTarget->loc.p);
    }

    // everything below require distance to be below 20
    if (currentDistance > 20)
    {
        return false;
    }

    if ((detects & DETECT_LOWHP) && PTarget->GetHPP() < 75)
    {
        return CanSeePoint(PTarget->loc.p);
    }

    if ((detects & DETECT_MAGIC) && PTarget->PAI->IsCurrentState<CMagicState>() &&
        static_cast<CMagicState*>(PTarget->PAI->GetCurrentState())->GetSpell()->hasMPCost())
    {
        return CanSeePoint(PTarget->loc.p);
    }

    if ((detects & DETECT_WEAPONSKILL) && PTarget->PAI->IsCurrentState<CWeaponSkillState>())
    {
        return CanSeePoint(PTarget->loc.p);
    }

    if ((detects & DETECT_JOBABILITY) && PTarget->PAI->IsCurrentState<CAbilityState>())
    {
        return CanSeePoint(PTarget->loc.p);
    }

    return false;
}

bool CMobController::CanSeePoint(position_t pos)
{
    TracyZoneScoped;
    if (PMob->PAI->PathFind)
    {
        return PMob->PAI->PathFind->CanSeePoint(pos);
    }

    return true;
}

bool CMobController::MobSkill(int wsList)
{
    TracyZoneScoped;
    /* #TODO: mob 2 hours, etc */
    if (!wsList) wsList = PMob->getMobMod(MOBMOD_SKILL_LIST);
    auto skillList {battleutils::GetMobSkillList(wsList)};

    if (skillList.empty())
    {
        return false;
    }

    std::shuffle(skillList.begin(), skillList.end(), tpzrand::mt());
    CBattleEntity* PActionTarget {nullptr};

    uint16 scriptChoice = luautils::OnMobWeaponSkillPrepare((CBaseEntity*)PMob, (CBaseEntity*)PTarget);
    if (scriptChoice != 0)
    {
        skillList.insert(skillList.begin(), scriptChoice);
    }

    for (auto skillid : skillList)
    {
        auto PMobSkill {battleutils::GetMobSkill(skillid)};
        if (!PMobSkill)
        {
            continue;
        }
        if (PMobSkill->getValidTargets() == TARGET_ENEMY) //enemy
        {
            PActionTarget = PTarget;
        }
        else if (PMobSkill->getValidTargets() == TARGET_SELF) //self
        {
            PActionTarget = PMob;
        }
        else
        {
            continue;
        }

        if (!PActionTarget) {
            continue;
        }

        float currentDistance = distance(PMob->loc.p, PActionTarget->loc.p);
        if (!PMobSkill->isTwoHour() && luautils::OnMobSkillCheck(PActionTarget, PMob, PMobSkill) == 0) //A script says that the move in question is valid
        {
            if (currentDistance <= PMobSkill->getDistance())
            {
                return MobSkill(PActionTarget->targid, PMobSkill->getID());
            }
        }
    }

    return false;
}

bool CMobController::TrySpecialSkill()
{
    TracyZoneScoped;
    // get my special skill
    CMobSkill* PSpecialSkill = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_SPECIAL_SKILL));
    CBattleEntity* PAbilityTarget = nullptr;
    m_LastSpecialTime = m_Tick;

    if (PSpecialSkill == nullptr) {
        ShowError("CAIMobDummy::ActionSpawn Special skill was set but not found! (%d)\n", PMob->getMobMod(MOBMOD_SPECIAL_SKILL));
        return false;
    }

    if (!IsWeaponSkillEnabled())
    {
        return false;
    }

    if ((PMob->m_specialFlags & SPECIALFLAG_HIDDEN) && !PMob->IsNameHidden())
    {
        return false;
    }

    if (PSpecialSkill->getValidTargets() & TARGET_SELF)
    {
        PAbilityTarget = PMob;
    }
    else if (PTarget != nullptr)
    {
        // distance check for special skill
        float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

        if (currentDistance <= PSpecialSkill->getDistance())
        {
            PAbilityTarget = PTarget;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }

    if (luautils::OnMobSkillCheck(PAbilityTarget, PMob, PSpecialSkill) == 0)
    {
        return MobSkill(PAbilityTarget->targid, PSpecialSkill->getID());
    }

    return false;
}

bool CMobController::TryCastSpell()
{
    TracyZoneScoped;
    if (!CanCastSpells())
    {
        return false;
    }

    m_LastMagicTime = m_Tick - std::chrono::milliseconds(tpzrand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_MAGIC_COOL) / 2));

    if (PMob->m_HasSpellScript)
    {
        // skip logic and follow script
        auto chosenSpellId = luautils::OnMonsterMagicPrepare(PMob, PTarget);
        if (chosenSpellId)
        {
            CastSpell(chosenSpellId.value());
            return true;
        }
    }
    else
    {
        // find random spell
        std::optional<SpellID> chosenSpellId;
        if (m_firstSpell)
        {
            // mobs first spell, should be aggro spell
            chosenSpellId = PMob->SpellContainer->GetAggroSpell();
            m_firstSpell = false;
        }
        else
        {
            chosenSpellId = PMob->SpellContainer->GetSpell();
        }

        if (chosenSpellId)
        {
            //#TODO: select target based on spell type
            CastSpell(chosenSpellId.value());
            return true;
        }
    }

    TapDeaggroTime();
    return false;
}

bool CMobController::CanCastSpells()
{
    TracyZoneScoped;
    if (!PMob->SpellContainer->HasSpells() && !PMob->m_HasSpellScript)
    {
        return false;
    }

    // check for spell blockers e.g. silence
    if (PMob->StatusEffectContainer->HasStatusEffect({EFFECT_SILENCE, EFFECT_MUTE}))
    {
        TapDeaggroTime();
        return false;
    }

    // smn can only cast spells if it has no pet
    if (PMob->GetMJob() == JOB_SMN)
    {
        if (PMob->PPet == nullptr ||
            !PMob->PPet->isDead())
        {
            return false;
        }
    }

    // mob has no mp and does not have manafont Exclude NIN and BRD
   // mob has no mp and does not have manafont Exclude NIN and BRD
    if (PMob->GetMJob() != JOB_NIN && PMob->GetSJob() != JOB_NIN &&
    PMob->GetMJob() != JOB_BRD && PMob->GetSJob() != JOB_BRD &&
    PMob->health.mp == 0 && !PMob->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT))
    {
        return false;
    }

    return IsMagicCastingEnabled();
}

void CMobController::CastSpell(SpellID spellid)
{
    TracyZoneScoped;
    CSpell* PSpell = spell::GetSpell(spellid);
    if (PSpell == nullptr)
    {
        ShowWarning(CL_YELLOW"ai_mob_dummy::CastSpell: SpellId <%i> is not found\n" CL_RESET, static_cast<uint16>(spellid));
    }
    else
    {
        CBattleEntity* PCastTarget = nullptr;
        // check valid targets
        if (PSpell->getValidTarget() & TARGET_SELF)
        {
            PCastTarget = PMob;

            // only buff other targets if i'm roaming
            if ((PSpell->getValidTarget() & TARGET_PLAYER_PARTY))
            {
                // chance to target my master
                if (PMob->PMaster != nullptr && tpzrand::GetRandomNumber(2) == 0)
                {
                    // target my master
                    PCastTarget = PMob->PMaster;
                }
                else if (tpzrand::GetRandomNumber(2) == 0)
                {
                    // chance to target party
                    PMob->PAI->TargetFind->reset();
                    PMob->PAI->TargetFind->findWithinArea(PMob, AOERADIUS_ATTACKER, PSpell->getRange());

                    if (!PMob->PAI->TargetFind->m_targets.empty())
                    {
                        // randomly select a target
                        PCastTarget = PMob->PAI->TargetFind->m_targets[tpzrand::GetRandomNumber(PMob->PAI->TargetFind->m_targets.size())];

                        // only target if are on same action
                        if (PMob->PAI->IsEngaged() == PCastTarget->PAI->IsEngaged())
                        {
                            PCastTarget = PMob;
                        }
                    }
                }
            }
        }
        else
        {
            PCastTarget = PTarget;
        }

        if (PCastTarget)
        {
            Cast(PCastTarget->targid, spellid);
        }
    }
}

void CMobController::DoCombatTick(time_point tick)
{
    TracyZoneScopedC(0xFF0000);
    if (PMob->m_OwnerID.targid != 0 && static_cast<CCharEntity*>(PMob->GetEntity(PMob->m_OwnerID.targid))->PClaimedMob != static_cast<CBattleEntity*>(PMob))
    {
        if (m_Tick >= m_DeclaimTime + 3s)
        {
            PMob->m_OwnerID.clean();
            PMob->updatemask |= UPDATE_STATUS;
        }
    }


    HandleEnmity();
    PTarget = static_cast<CBattleEntity*>(PMob->GetEntity(PMob->GetBattleTargetID()));

    if (TryDeaggro())
    {
        Disengage();
        return;
    }

    TryLink();

    float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

    PMob->PAI->EventHandler.triggerListener("COMBAT_TICK", PMob);
    luautils::OnMobFight(PMob, PTarget);

    // Try to spellcast (this is done first so things like Chainspell spam is prioritised over TP moves etc.
    if (IsSpecialSkillReady(currentDistance) && TrySpecialSkill())
    {
        return;
    }
    else if (IsSpellReady(currentDistance) && TryCastSpell())
    {
        return;
    }
    else if (PMob->health.tp >= 1000 && PMob->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI) && MobSkill())
    {
        return;
    }
    else if (m_Tick >= m_LastMobSkillTime && tpzrand::GetRandomNumber(1, 10000) <= PMob->TPUseChance() && MobSkill())
    {
        return;
    }

    Move();
}

void CMobController::FaceTarget(uint16 targid)
{
    TracyZoneScoped;
    if (PMob->PAI->IsCurrentState<CInactiveState>())
    {
        return;
    }

    CBaseEntity* targ = PTarget;
    if (targid != 0 && ((targ && targid != targ->targid ) || !targ))
    {
        targ = PMob->GetEntity(targid);
    }
    if (!(PMob->m_Behaviour & BEHAVIOUR_NO_TURN) && targ)
    {
        PMob->PAI->PathFind->LookAt(targ->loc.p);
    }
}

void CMobController::Move()
{
    TracyZoneScoped;
    if (!PMob->PAI->CanFollowPath())
    {
        return;
    }
    if (PMob->PAI->PathFind->IsFollowingScriptedPath() && PMob->PAI->CanFollowPath())
    {
        PMob->PAI->PathFind->FollowPath();
        return;
    }

    // attempt to teleport
    if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 1)
    {
        if (m_Tick >= m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_TELEPORT_CD)))
        {
            CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START));

            if (teleportBegin)
            {
                m_LastSpecialTime = m_Tick;
                MobSkill(PMob->targid, teleportBegin->getID());
            }
        }
    }

    bool move = PMob->PAI->PathFind->IsFollowingPath();
    float attack_range = PMob->GetMeleeRange();
    float closureDistance = PMob->getMobMod(MOBMOD_ENCROACH_PLAYER) ? attack_range - 3.7f : attack_range - 0.2f;

    if (PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST) > 0)
    {
        auto skillList {battleutils::GetMobSkillList(PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST))};

        if (!skillList.empty())
        {
            auto skill {battleutils::GetMobSkill(skillList.front())};
            if (skill)
            {
                attack_range = skill->getDistance();
            }
        }
    }

    float currentDistance = distance(PMob->loc.p, PTarget->loc.p);
    if (PMob->getMobMod(MOBMOD_SHARE_POS) > 0)
    {
        CMobEntity* posShare = (CMobEntity*)PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_POS) + PMob->targid, TYPE_MOB);
        PMob->loc = posShare->loc;
    }
    else if (((currentDistance > closureDistance) || move) && PMob->PAI->CanFollowPath())
    {
        if (PMob->getMobMod(MOBMOD_DRAW_IN))
        {
            uint8 drawInRange = PMob->getMobMod(MOBMOD_DRAW_IN_CUSTOM_RANGE) > 0 ? PMob->getMobMod(MOBMOD_DRAW_IN_CUSTOM_RANGE) : PMob->GetMeleeRange() * 2;
            uint16 maximumReach = PMob->getMobMod(MOBMOD_DRAW_IN_MAXIMUM_REACH) > 0 ? PMob->getMobMod(MOBMOD_DRAW_IN_MAXIMUM_REACH) : 0xFFFF;
            bool includeParty = PMob->getMobMod(MOBMOD_DRAW_IN_INCLUDE_PARTY); // (and alliance)

            if (currentDistance > drawInRange && currentDistance < maximumReach && battleutils::DrawIn(PTarget, PMob, PMob->GetMeleeRange() - 0.2f, drawInRange, maximumReach, includeParty))
            {
                FaceTarget();
                m_DrawInWait = server_clock::now() + 500ms;
            }
            else
            {
                drawInRange = PMob->GetMeleeRange(); // if i'm bound/can't move, draw in the moment they leave my melee range
                if ((PMob->speed == 0 || PMob->getMobMod(MOBMOD_NO_MOVE)) && !PMob->getMobMod(MOBMOD_DRAW_IN_IGNORE_STATIONARY) &&
                currentDistance > drawInRange && currentDistance < maximumReach && battleutils::DrawIn(PTarget, PMob, PMob->GetMeleeRange() - 1.2f, drawInRange, maximumReach, includeParty))
                {
                    FaceTarget();
                }
            }
        }
        if (PMob->speed != 0 && PMob->getMobMod(MOBMOD_NO_MOVE) == 0 && m_Tick >= m_LastSpecialTime)
        {
            // attempt to teleport to target (if in range)
            if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 2)
            {
                CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START));

                if (teleportBegin && currentDistance <= teleportBegin->getDistance())
                {
                    MobSkill(PMob->targid, teleportBegin->getID());
                    m_LastSpecialTime = m_Tick;
                    return;
                }
            }
            else if (CanMoveForward(currentDistance) && m_DrawInWait < server_clock::now())
            {
                if ((!PMob->PAI->PathFind->IsFollowingPath() || distanceSquared(PMob->PAI->PathFind->GetDestination(), PTarget->loc.p) > 10) && currentDistance > closureDistance)
                {
                    //path to the target if we don't have a path already
                    PMob->PAI->PathFind->PathInRange(PTarget->loc.p, closureDistance, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                }
                PMob->PAI->PathFind->FollowPath();
                if (!PMob->PAI->PathFind->IsFollowingPath())
                {
                    //arrived at target - move if there is another mob under me
                    if (PTarget->objtype == TYPE_PC)
                    {
                        for (auto PSpawnedMob : static_cast<CCharEntity*>(PTarget)->SpawnMOBList)
                        {
                            if (PSpawnedMob.second != PMob && !PSpawnedMob.second->PAI->PathFind->IsFollowingPath() && distanceSquared(PSpawnedMob.second->loc.p, PMob->loc.p) < 1.f)
                            {
                                auto angle = worldAngle(PMob->loc.p, PTarget->loc.p) + 64;
                                position_t new_pos {PMob->loc.p.x - (cosf(rotationToRadian(angle)) * 1.5f),
                                    PTarget->loc.p.y, PMob->loc.p.z + (sinf(rotationToRadian(angle)) * 1.5f), 0, 0};
                                if (PMob->PAI->PathFind->ValidPosition(new_pos))
                                {
                                    PMob->PAI->PathFind->PathTo(new_pos, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                                }
                                break;
                            }
                        }
                    }
                }
            }
            else
            {
                FaceTarget();
            }
        }
    }
    else
    {
        FaceTarget();
    }
}

void CMobController::HandleEnmity()
{
    TracyZoneScoped;
    PMob->PEnmityContainer->DecayEnmity();
    if (PMob->getMobMod(MOBMOD_SHARE_TARGET) > 0 && PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_TARGET), TYPE_MOB))
    {
        ChangeTarget(static_cast<CMobEntity*>(PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_TARGET), TYPE_MOB))->GetBattleTargetID());

        if (!PMob->GetBattleTargetID())
        {
            auto PTarget {PMob->PEnmityContainer->GetHighestEnmity()};
            ChangeTarget(PTarget ? PTarget->targid : 0);
        }
    }
    else
    {
        auto PTarget {PMob->PEnmityContainer->GetHighestEnmity()};
        if (PTarget) ChangeTarget(PTarget->targid);
    }
}

void CMobController::DoRoamTick(time_point tick)
{
    TracyZoneScopedC(0x00FF00);
    // If there's someone on our enmity list, go from roaming -> engaging
    if (PMob->PEnmityContainer->GetHighestEnmity() != nullptr && !(PMob->m_roamFlags & ROAMFLAG_IGNORE))
    {
        Engage(PMob->PEnmityContainer->GetHighestEnmity()->targid);
        return;
    }
    else if (PMob->m_OwnerID.id != 0 && !(PMob->m_roamFlags & ROAMFLAG_IGNORE))
    {
        // i'm claimed by someone and need hate towards this person
        PTarget = (CBattleEntity*)PMob->GetEntity(PMob->m_OwnerID.targid, TYPE_PC | TYPE_MOB | TYPE_PET | TYPE_TRUST);

        PMob->PEnmityContainer->AddBaseEnmity(PTarget);

        Engage(PTarget->targid);
        return;
    }
    //#TODO
    else if (PMob->GetDespawnTime() > time_point::min() && PMob->GetDespawnTime() < m_Tick)
    {
        Despawn();
        return;
    }

    if (PMob->m_roamFlags & ROAMFLAG_IGNORE)
    {
        // don't claim me if I ignore
        PMob->m_OwnerID.clean();
    }

    //skip roaming if waiting
    if (m_Tick >= m_WaitTime)
    {
        // don't aggro a little bit after I just disengaged
        PMob->m_neutral = PMob->CanBeNeutral() && m_Tick <= m_NeutralTime + 10s;

        if (PMob->PAI->PathFind->IsFollowingPath())
        {
            FollowRoamPath();
                if (m_Tick >=m_LastActionTime + std::chrono::seconds(10) && PMob->CanRest())
                {
                    if (PMob->Rest(0.1f))
                    {
                        PMob->updatemask |= UPDATE_HP;
                    }
                    m_LastActionTime = m_Tick;
                }
        }
        else if (m_Tick >= m_LastActionTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)))
        {
            // lets buff up or move around

            if (PMob->CalledForHelp())
            {
                PMob->CallForHelp(false);
            }

            // can't rest with poison or disease
            if (PMob->CanRest() && PMob->getMobMod(MOBMOD_NO_REST) == 0)
            {
                // recover 10% health
                if (PMob->Rest(0.1f))
                {
                    // health updated
                    PMob->updatemask |= UPDATE_HP;
                }

                if (PMob->GetHPP() == 100)
                {
                    // at max health undirty exp
                    PMob->m_HiPCLvl = 0;
                    PMob->m_HiPartySize = 0;
                    PMob->m_giveExp = true;
                    PMob->m_ExpPenalty = 0;    
                }
            }

            // if I just disengaged check if I should despawn
            if (PMob->IsFarFromHome())
            {
                if (PMob->CanRoamHome() && PMob->PAI->PathFind->PathTo(PMob->m_SpawnPoint))
                {
                    // walk back to spawn if too far away

                    // limit total path to just 20 or
                    // else we'll move straight back to spawn
                    PMob->PAI->PathFind->LimitDistance(20.0f);

                    FollowRoamPath();

                    // move back every 5 seconds
                    m_LastActionTime = m_Tick - (std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)) + 10s);
                }
                else if (!PMob->getMobMod(MOBMOD_NO_DESPAWN) && !map_config.mob_no_despawn)
                {
                    PMob->PAI->Despawn();
                    return;
                }
            }
            else
            {
                // No longer including conditional for ROAMFLAG_AMBUSH now that using mixin to handle mob hiding
                if (PMob->getMobMod(MOBMOD_SPECIAL_SKILL) != 0 &&
                    m_Tick > m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL)) &&
                    TrySpecialSkill())
                {
                    // I spawned a pet
                }
                else if (PMob->GetMJob() == JOB_SMN && CanCastSpells() && PMob->SpellContainer->HasBuffSpells() &&
                    m_Tick > m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL)) &&
                    m_Tick >= m_LastMagicTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_MAGIC_COOL)))
                {
                    // summon pet
                    auto spellID = PMob->SpellContainer->GetBuffSpell();
                    if(spellID)
                    {
                        CastSpell(spellID.value());
                        m_LastSpecialTime = m_Tick;
                    }
                }
                else if (CanCastSpells() && tpzrand::GetRandomNumber(10) < 3 && PMob->SpellContainer->HasBuffSpells())
                {
                    // cast buff
                    auto spellID = PMob->SpellContainer->GetBuffSpell();
                    if(spellID)
                        CastSpell(spellID.value());
                }
                else if (PMob->m_roamFlags & ROAMFLAG_EVENT)
                {
                    // allow custom event action
                    luautils::OnMobRoamAction(PMob);
                    m_LastActionTime = m_Tick;
                }
                else if (PMob->CanRoam() && PMob->PAI->PathFind->RoamAround(PMob->m_SpawnPoint, PMob->GetRoamDistance(), (uint8)PMob->getMobMod(MOBMOD_ROAM_TURNS), PMob->m_roamFlags))
                {
                    //#TODO: #AIToScript (event probably)
                    if (PMob->m_roamFlags & ROAMFLAG_WORM)
                    {
                        // move down
                        PMob->animationsub = 1;
                        PMob->HideName(true);
                        PMob->Untargetable(true);

                        // don't move around until i'm fully in the ground
                        Wait(2s);
                    }
                    else if ((PMob->m_roamFlags & ROAMFLAG_STEALTH))
                    {
                        // hidden name
                        PMob->HideName(true);
                        PMob->Untargetable(true);

                        PMob->updatemask |= UPDATE_HP;
                    }
                    else
                    {
                        FollowRoamPath();
                    }
                }
                else
                {
                    m_LastActionTime = m_Tick;
                }
            }
        }
    }
    if (m_Tick >= m_LastRoamScript + 3s)
    {
        PMob->PAI->EventHandler.triggerListener("ROAM_TICK", PMob);
        luautils::OnMobRoam(PMob);
        m_LastRoamScript = m_Tick;
    }
}

void CMobController::Wait(duration _duration)
{
    if (m_Tick > m_WaitTime)
    {
        m_WaitTime = m_Tick += _duration;
    }
    else
    {
        m_WaitTime += _duration;
    }
}

void CMobController::FollowRoamPath()
{
    TracyZoneScoped;
    if (PMob->PAI->CanFollowPath())
    {
        PMob->PAI->PathFind->FollowPath();

        CBattleEntity* PPet = PMob->PPet;
        if (PPet != nullptr && PPet->PAI->IsSpawned() && !PPet->PAI->IsEngaged())
        {
            // pet should follow me if roaming
            position_t targetPoint = nearPosition(PMob->loc.p, 2.1f, (float)M_PI);

            PPet->PAI->PathFind->PathTo(targetPoint);
        }

        // if I just finished reset my last action time
        if (!PMob->PAI->PathFind->IsFollowingPath())
        {
            uint16 roamRandomness = (uint16)(PMob->getBigMobMod(MOBMOD_ROAM_COOL) / PMob->GetRoamRate());
            m_LastActionTime = m_Tick - std::chrono::milliseconds(tpzrand::GetRandomNumber(roamRandomness));

            // i'm a worm pop back up
            if (PMob->m_roamFlags & ROAMFLAG_WORM)
            {
                PMob->animationsub = 0;
                PMob->HideName(false);
                PMob->Untargetable(false);
            }

            // face spawn rotation if I just moved back to spawn
            // used by dynamis mobs, bcnm mobs etc
            if ((PMob->m_roamFlags & ROAMFLAG_EVENT) &&
                distance(PMob->loc.p, PMob->m_SpawnPoint) <= PMob->m_maxRoamDistance)
            {
                PMob->loc.p.rotation = PMob->m_SpawnPoint.rotation;
            }
        }


        if (PMob->PAI->PathFind->OnPoint()) {
            luautils::OnPath(PMob);
        }
    }
}

void CMobController::Despawn()
{
    TracyZoneScoped;
    if (PMob)
    {
        PMob->PAI->Internal_Despawn();
    }
}

void CMobController::Reset()
{
    TracyZoneScoped;
    // Wait a little before roaming / casting spell / spawning pet
    m_LastActionTime = m_Tick - std::chrono::milliseconds(tpzrand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_ROAM_COOL)));

    // Don't attack player right off of spawn
    PMob->m_neutral = true;
    m_NeutralTime = m_Tick;

    PTarget = nullptr;
}

bool CMobController::MobSkill(uint16 targid, uint16 wsid)
{
    TracyZoneScoped;
    if (POwner)
    {
        FaceTarget(targid);
        return POwner->PAI->Internal_MobSkill(targid, wsid);
    }

    return false;
}

bool CMobController::Disengage()
{
    TracyZoneScoped;
    // this will let me decide to walk home or despawn
    m_LastActionTime = m_Tick - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)) + 10s;
    PMob->m_neutral = true;
    m_NeutralTime = m_Tick;

    PMob->PAI->PathFind->Clear();
    PMob->PEnmityContainer->Clear();

    if (PMob->getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        PMob->SetDespawnTime(std::chrono::seconds(PMob->getMobMod(MOBMOD_IDLE_DESPAWN)));
    }

    PMob->m_OwnerID.clean();
    PMob->updatemask |= (UPDATE_STATUS | UPDATE_HP);
    PMob->CallForHelp(false);
    PMob->animation = ANIMATION_NONE;
    PMob->m_UsedSkillIds.clear();

    return CController::Disengage();
}

bool CMobController::Engage(uint16 targid)
{
    TracyZoneScoped;
    auto ret = CController::Engage(targid);
    if (ret)
    {
        m_firstSpell = true;

        // randomize to have TryLink only run every 4th server tick, but not the _same_ tick for all linked mobs
        m_TryLinkSkippedTicks = tpzrand::GetRandomNumber(0,TRY_LINK_TICK_FREQUENCY - 1);

        if (PMob->isInDynamis() && PMob->GetMJob() == JOB_SMN)
        { // dyna SMN: summon my avatar immediately
            m_LastMagicTime = m_Tick;
            m_LastSpecialTime = m_Tick;
            if (CanCastSpells() && PMob->SpellContainer->HasBuffSpells() && (!PMob->PPet || PMob->PPet->isDead()))
            {
                if (auto spellID = PMob->SpellContainer->GetBuffSpell())
                    CastSpell(spellID.value());
            }
            return ret;
        }

        // Don't cast magic or use special ability right away
        if (PMob->getBigMobMod(MOBMOD_MAGIC_DELAY) != 0)
        {
            m_LastMagicTime = m_Tick - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_MAGIC_COOL) + tpzrand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_MAGIC_DELAY)));
        }

        if (PMob->getBigMobMod(MOBMOD_SPECIAL_DELAY) != 0)
        {
            m_LastSpecialTime = m_Tick - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL) + tpzrand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_SPECIAL_DELAY)));
        }
    }
    return ret;
}

int32 CMobController::GetFomorHate(CBattleEntity* PTarget)
{
    if (!PTarget || PTarget->objtype != TYPE_PC) {
        return -1;
    }
    CCharEntity* PChar = (CCharEntity*)PTarget;
    int32 hate = (int32)PChar->m_fomorHate;
    PChar->ForAlliance([PChar, &hate](CBattleEntity* PMember)
    {
        if (PMember->id != PChar->id && PMember->objtype == TYPE_PC && PMember->loc.zone->GetID() == PChar->loc.zone->GetID()) {
            int32 memberHate = ((CCharEntity*)PMember)->m_fomorHate;
            if (memberHate > hate) {
                hate = memberHate;
            }
        }
    });
    return hate;
}

int32 CMobController::GetPixieHate(CBattleEntity* PTarget)
{
    if (!PTarget || PTarget->objtype != TYPE_PC) {
        return -1;
    }
    CCharEntity* PChar = (CCharEntity*)PTarget;
    int32 hate = (int32)PChar->m_pixieHate;
    return hate;
}

bool CMobController::CanAggroTarget(CBattleEntity* PTarget)
{
    TracyZoneScoped;
    TracyZoneIString(PMob->GetName());
    TracyZoneIString(PTarget->GetName());

    // Don't aggro I just uncharmed a few seconds ago
    if (m_Tick < PMob->m_UncharmTime + 7s)
    {
        return false;
    }

    // Don't aggro I'm neutral
    if ((PMob->getMobMod(MOBMOD_ALWAYS_AGGRO) == 0 && !PMob->m_Aggro) || PMob->m_neutral || PMob->isDead())
    {
        return false;
    }

    // Don't aggro I'm special
    if (PMob->getMobMod(MOBMOD_NO_AGGRO) > 0)
    {
        return false;
    }

    // Don't aggro I was recently released by a BST with the Leave command
    if (PMob->aggroTimer > (uint32)CVanaTime::getInstance()->getVanaTime())
    {
        return false;
    }

    // Don't aggro I'm an underground worm
    if ((PMob->m_roamFlags & ROAMFLAG_WORM) && PMob->IsNameHidden())
    {
        return false;
    }

    if (PTarget->isDead() || PTarget->isMounted())
    {
        return false;
    }

    // Don't aggro I'm a fomor and I don't hate you
    if (PMob->getMobMod(MOBMOD_FOMOR_HATE) > 0)
    {
        int32 hate = GetFomorHate(PTarget);
        if (hate >= 0 && hate < 8) {
            return false;
        }
    }
    // Don't aggro I'm a pixie and I don't hate you
    if (PMob->getMobMod(MOBMOD_PIXIE) > 0) {
        if (PTarget->objtype != TYPE_PC) {
            return false;
        }
        CCharEntity* PChar = (CCharEntity*)PTarget;
        uint32 threshold = PMob->PixieGetHealHateThreshold(PChar);
        if (PChar->m_pixieHate < threshold) {
            return false;
        }
        if (PChar->m_pixieHate < 60 && PChar->m_pixieHate < threshold * 2) {
            return false;
        }
    }

    if (PTarget->objtype == TYPE_PC && server_clock::now() < ((CCharEntity*)PTarget)->m_ZoneAggroImmunity)
    {
        return false;
    }

    if (PMob->PAI && PMob->PAI->IsCurrentState<CClaimShieldState>())
    {
        return false;
    }

    if (PMob->PMaster == nullptr && PMob->PAI->IsSpawned() && !PMob->PAI->IsEngaged() && CanDetectTarget(PTarget, false))
    {
        return true;
    }

    return false;
}

void CMobController::TapDeaggroTime()
{
    m_DeaggroTime = m_Tick;
}

void CMobController::TapDeclaimTime()
{
    m_DeclaimTime = m_Tick;
}

bool CMobController::DeaggroEntity(CBattleEntity* PEntity)
{
    if (!PEntity) {
        return false;
    }
    m_forcedDeaggroEntities.push_back(PEntity);
    return true;
}

bool CMobController::DeaggroAll()
{
    m_forceDeaggroAll = true;
    return true;
}

bool CMobController::Cast(uint16 targid, SpellID spellid)
{
    TracyZoneScoped;
    FaceTarget(targid);
    return CController::Cast(targid, spellid);
}

bool CMobController::CanMoveForward(float currentDistance)
{
    TracyZoneScoped;
    if(PMob->objtype == TYPE_PET && PMob->PMaster && PMob->PMaster->objtype == TYPE_PC && static_cast<CPetEntity*>(PMob)->getPetType() == PETTYPE_AUTOMATON && PMob->m_Behaviour & BEHAVIOUR_STANDBACK && currentDistance < 21)
    {
        return false;
    }

    if(PMob->m_Behaviour & BEHAVIOUR_STANDBACK && currentDistance < 20)
    {
        return false;
    }

    if(PMob->getMobMod(MOBMOD_NO_STANDBACK) == 0 && PMob->getMobMod(MOBMOD_HP_STANDBACK) > 0 && currentDistance < 20 && PMob->GetHPP() >= PMob->getMobMod(MOBMOD_HP_STANDBACK))
    {
        // Excluding Nins, mobs should not standback if can't cast magic
        if (PMob->GetMJob() != JOB_NIN && PMob->SpellContainer->HasSpells() && !CanCastSpells())
        {
            return true;
        }

        return false;
    }

    if(PMob->getMobMod(MOBMOD_SPAWN_LEASH) > 0 && distance(PMob->loc.p, PMob->m_SpawnPoint) > PMob->getMobMod(MOBMOD_SPAWN_LEASH))
    {
        return false;
    }

    return true;
}

bool CMobController::IsSpecialSkillReady(float currentDistance)
{
    TracyZoneScoped;
    if (PMob->getMobMod(MOBMOD_SPECIAL_SKILL) == 0) return false;

    if (PMob->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL)) return false;

    int32 bonusTime = 0;
    if (currentDistance > 5)
    {
        // Mobs use ranged attacks quicker when standing back
        bonusTime = PMob->getBigMobMod(MOBMOD_STANDBACK_COOL);
    }

    if(m_Tick >= m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL) - bonusTime))
    {
        return true;
    }

    return false;
}

bool CMobController::IsSpellReady(float currentDistance)
{
    TracyZoneScoped;
    int32 bonusTime = 0;
    if (currentDistance > 5)
    {
        // Mobs use ranged attacks quicker when standing back
        bonusTime = PMob->getBigMobMod(MOBMOD_STANDBACK_COOL);
    }

    if (PMob->StatusEffectContainer->HasStatusEffect({EFFECT_CHAINSPELL,EFFECT_MANAFONT}) && currentDistance < 26.8)
    {
        return true;
    }
// TODO: return false if the mob can't cast for some reason. Maybe it should be done in a different function, but
// if the below is true but the target is out of range, the mob will just stand still
    return (m_Tick >= m_LastMagicTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_MAGIC_COOL) - bonusTime));
}
