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

#include "../../common/showmsg.h"
#include "../../common/utils.h"

#include "battleentity.h"

#include "../ai/ai_container.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/death_state.h"
#include "../ai/states/despawn_state.h"
#include "../ai/states/inactive_state.h"
#include "../ai/states/magic_state.h"
#include "../ai/states/raise_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../attack.h"
#include "../attackround.h"
#include "../notoriety_container.h"
#include "../items/item_weapon.h"
#include "../lua/luautils.h"
#include "../mob_modifier.h"
#include "../packets/action.h"
#include "../recast_container.h"
#include "../roe.h"
#include "../status_effect_container.h"
#include "../enmity_container.h"
#include "../utils/battleutils.h"
#include "../utils/petutils.h"
#include "../utils/puppetutils.h"
#include "../weapon_skill.h"

CBattleEntity::CBattleEntity()
{
    m_OwnerID.clean();
    m_ModelSize = 0;
    m_mlvl = 0;
    m_slvl = 0;

    m_mjob = JOB_WAR;
    m_sjob = JOB_WAR;

    m_magicEvasion = 0;

    m_Weapons[SLOT_MAIN] = new CItemWeapon(0);
    m_Weapons[SLOT_SUB] = new CItemWeapon(0);
    m_Weapons[SLOT_RANGED] = new CItemWeapon(0);
    m_Weapons[SLOT_AMMO] = new CItemWeapon(0);
    m_dualWield = false;

    memset(&stats, 0, sizeof(stats));
    memset(&health, 0, sizeof(health));
    health.maxhp = 1;
    health.maxtp = 3000;

    memset(&WorkingSkills, 0, sizeof(WorkingSkills));

    PPet = nullptr;
    PParty = nullptr;
    PMaster = nullptr;
    PLastAttacker = nullptr;

    StatusEffectContainer = std::make_unique<CStatusEffectContainer>(this);
    PRecastContainer = std::make_unique<CRecastContainer>(this);
    PNotorietyContainer = std::make_unique<CNotorietyContainer>(this);

    m_modStat[Mod::SLASHRES] = 1000;
    m_modStat[Mod::PIERCERES] = 1000;
    m_modStat[Mod::H2HRES] = 1000;
    m_modStat[Mod::IMPACTRES] = 1000;
    m_modStat[Mod::MOVE] = 0;

    m_Immunity = 0;
    isCharmed = false;
    isSuperJumped = false;
    m_unkillable = false;
    m_dmgType = (DAMAGETYPE)0;

    m_drawInOffsetY = -1.0f;
}

CBattleEntity::~CBattleEntity()
{
}

bool CBattleEntity::isDead()
{
    return (health.hp <= 0 || status == STATUS_DISAPPEAR ||
        PAI->IsCurrentState<CDeathState>() || PAI->IsCurrentState<CDespawnState>());
}

bool CBattleEntity::isAlive()
{
    return !isDead();
}

bool CBattleEntity::isInDynamis()
{
    if (loc.zone != nullptr) {
        return loc.zone->GetType() == ZONETYPE_DYNAMIS;
    }
    return false;
}

bool CBattleEntity::isInAssault()
{
    if (loc.zone != nullptr)
    {
        return loc.zone->GetType() == ZONETYPE_DUNGEON_INSTANCED && (loc.zone->GetRegionID() >= REGION_WEST_AHT_URHGAN && loc.zone->GetRegionID() <= REGION_ALZADAAL);
    }
    return false;
}

// return true if the mob has immunity
bool CBattleEntity::hasImmunity(uint32 imID)
{
    if (objtype == TYPE_MOB || objtype == TYPE_PET) {
        IMMUNITY mobImmunity = (IMMUNITY)imID;
        return (m_Immunity & mobImmunity);
    }
    return false;
}

bool CBattleEntity::isAsleep()
{
    return PAI->IsCurrentState<CInactiveState>();
}

bool CBattleEntity::isMounted()
{
	return (animation == ANIMATION_CHOCOBO || animation == ANIMATION_MOUNT);
}

bool CBattleEntity::isSitting()
{
    return (animation == ANIMATION_HEALING || animation == ANIMATION_SIT || (animation >= ANIMATION_SITCHAIR_0 && animation <= ANIMATION_SITCHAIR_10));
}

/*************************************************************************************
*                                                                                    *
*  Пересчитываем максимальные значения hp и mp с учетом модификаторов                *
*  We recalculate the maximum values ​​of hp and mp taking into account the modifiers  *
*                                                                                    *
**************************************************************************************/

void CBattleEntity::UpdateHealth()
{
    TracyZoneScoped;
    int32 dif = (getMod(Mod::CONVMPTOHP) - getMod(Mod::CONVHPTOMP));

    health.modmp = std::max(0, ((health.maxmp) * (100 + getMod(Mod::MPP)) / 100) + std::min<int16>((health.maxmp * m_modStat[Mod::FOOD_MPP] / 100), m_modStat[Mod::FOOD_MP_CAP]) + getMod(Mod::MP));
    health.modhp = std::max(1, ((health.maxhp) * (100 + getMod(Mod::HPP)) / 100) + std::min<int16>((health.maxhp * m_modStat[Mod::FOOD_HPP] / 100), m_modStat[Mod::FOOD_HP_CAP]) + getMod(Mod::HP));
    health.modtp = health.maxtp + getMod(Mod::MAX_TP);

    dif = (health.modmp - 0) < dif ? (health.modmp - 0) : dif;
    dif = (health.modhp - 1) < -dif ? -(health.modhp - 1) : dif;

    health.modhp += dif;
    health.modmp -= dif;

    if (objtype == TYPE_PC)
    {
        health.modhp = std::clamp(health.modhp, 1, 9999);
        health.modmp = std::clamp(health.modmp, 0, 9999);
    }

    health.hp = std::clamp(health.hp, 0, health.modhp);
    health.mp = std::clamp(health.mp, 0, health.modmp);
    health.tp = std::clamp((int)health.tp, 0, (int)health.modtp);

    updatemask |= UPDATE_HP;
}

/************************************************************************
*                                                                       *
*  Получаем текущее количество очков жизней                             *
*                                                                       *
************************************************************************/

uint8 CBattleEntity::GetHPP()
{
    uint8 hpp = (uint8)floor(((float)health.hp / (float)GetMaxHP()) * 100);
    // handle the edge case where a floor would show a mob with 1/1000 hp as 0
    if (hpp == 0 && health.hp > 0)
    {
        hpp = 1;
    }

    return hpp;
}

int32 CBattleEntity::GetMaxHP()
{
    return health.modhp;
}

/************************************************************************
*                                                                       *
*  Получаем текущее количество очков маны                               *
*                                                                       *
************************************************************************/

uint8 CBattleEntity::GetMPP()
{
    return (uint8)ceil(((float)health.mp / (float)GetMaxMP()) * 100);
}

int32 CBattleEntity::GetMaxMP()
{
    return health.modmp;
}

/************************************************************************
*                                                                       *
*  Movement speed, taking into account modifiers                        *
*  Note: retail speeds show as a float in the client,                   *
*        yet in the packet it seems to be just one byte 0-255..         *
*                                                                       *
************************************************************************/

uint8 CBattleEntity::GetSpeed()
{
    TracyZoneScoped;
    int16 startingSpeed = isMounted() ? 40 + map_config.mount_speed_mod : speed;

    // Mod::MOVE (169)
    // Mod::MOUNT_MOVE (972)
    Mod mod = isMounted() ? Mod::MOUNT_MOVE : Mod::MOVE;

    float modAmount = (100.0f + static_cast<float>(getMod(mod))) / 100.0f;
    // Cap unmounted movement speed increase to 50%, max quickening (25 - chocobo mazurka/jig) + max gear movement (25 ninja af+1)
    if (mod == Mod::MOVE)
    {
        if (StatusEffectContainer->GetStatusEffect(EFFECT_FLEE))
        {
            modAmount = std::clamp(modAmount, 0.0f, 2.0f);
        }
        else
        {
            modAmount = std::clamp(modAmount, 0.0f, 1.50f);
        }
    }

    float modifiedSpeed = static_cast<float>(startingSpeed) * modAmount;
    uint8 outputSpeed = static_cast<uint8>(modifiedSpeed < 0 ? 0 : modifiedSpeed);

    return std::clamp<uint8>(outputSpeed, std::numeric_limits<uint8>::min(), std::numeric_limits<uint8>::max());
}

bool CBattleEntity::CanRest()
{
    return !getMod(Mod::REGEN_DOWN) && !StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_NO_REST);
}

bool CBattleEntity::Rest(float rate)
{
    if (health.hp != health.maxhp || health.mp != health.maxmp) {
        // recover 20% HP
        uint32 recoverHP = (uint32)(health.maxhp * rate);
        uint32 recoverMP = (uint32)(health.maxmp * rate);
        addHP(recoverHP);
        addMP(recoverMP);

        // lower TP
        addTP((int16)(rate * -500));
        return true;
    }

    return false;
}

float CBattleEntity::GetStoreTPMultiplier()
{
    uint8 samuraiMeritBonus = 0;
    if (objtype == TYPE_PC)
    {
        auto PChar = (CCharEntity*)this;
        if (PChar->GetMJob() == JOB_SAM)
        {
            samuraiMeritBonus = PChar->PMeritPoints->GetMeritValue(MERIT_STORE_TP_EFFECT, PChar);
        }
    }

    return 1.0f + 0.01f * (float)((getMod(Mod::STORETP) + samuraiMeritBonus));
}

float CBattleEntity::GetJumpTPBonus()
{
    if ((float)getMod(Mod::JUMP_TP_BONUS) != 0)
    {
        return (float)(getMod(Mod::JUMP_TP_BONUS));
    }
    else
    {
        return 0;
    }
}

int16 CBattleEntity::GetWeaponDelay(bool tp)
{
    TracyZoneScoped;
    uint16 WeaponDelay = 9999;
    if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
    {
        uint16 MinimumDelay = weapon->getDelay(); // Track base delay.  We will need this later.  Mod::DELAY is ignored for now.
        WeaponDelay = weapon->getDelay() - getMod(Mod::DELAY);
        if (weapon->isHandToHand())
        {
            WeaponDelay -= getMod(Mod::MARTIAL_ARTS) * 1000 / 60;
            MinimumDelay -= getMod(Mod::MARTIAL_ARTS) * 1000 / 60;
        }
        else if (auto subweapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]); subweapon && subweapon->getDmgType() > 0 &&
            subweapon->getDmgType() < 4)
        {
            MinimumDelay += subweapon->getDelay();
            WeaponDelay += subweapon->getDelay();
            //apply dual wield delay reduction
            WeaponDelay = (uint16)(WeaponDelay * ((100.0f - getMod(Mod::DUAL_WIELD)) / 100.0f));
        }
        if ((!weapon || weapon->isHandToHand()) && this->StatusEffectContainer->HasStatusEffect(EFFECT_FOOTWORK))
            WeaponDelay = 480 * 1000 / 60;
        //apply haste and delay reductions that don't affect tp
        if (!tp)
        {
            // Cap haste at appropriate levels.
            int16 hasteMagic = std::clamp<int16>(getMod(Mod::HASTE_MAGIC), -10000, 4375); // 43.75% cap -- handle 100% slow for weakness
            int16 hasteAbility = std::clamp<int16>(getMod(Mod::HASTE_ABILITY), -2500, 2500); // 25% cap
            int16 hasteGear = std::clamp<int16>(getMod(Mod::HASTE_GEAR), -2500, 2500); // 25%

            if (StatusEffectContainer->HasStatusEffect(EFFECT_HUNDRED_FISTS))
            {
                hasteMagic = 8000;
                hasteAbility = 0;
                hasteGear = 0;
            }

            bool specialAttackList = false;

            // Check if we are using a special attack list that should not be affected by attack speed debuffs
            // Example: Wyrm's flying auto attack speed should not be modified by debuffs.
            if (this->objtype == TYPE_MOB)
                if (((CMobEntity*)this)->getMobMod(MOBMODIFIER::MOBMOD_ATTACK_SKILL_LIST) != 0)
                    specialAttackList = true;

            // Divide by float to get a more accurate reduction, then use int16 cast to truncate
            if (!specialAttackList)
                WeaponDelay -= (int16)(WeaponDelay * (hasteMagic + hasteAbility + hasteGear) / 10000.f);
        }
        
        WeaponDelay = (uint16)(WeaponDelay * ((100.0f + getMod(Mod::DELAYP)) / 100.0f));

        // Global delay reduction cap of "about 80%" being enforced.
        // This should be enforced on -delay equipment, martial arts, dual wield, and haste, hence MinimumDelay * 0.2.
        // TODO: Could be converted to value/1024 if the exact cap is ever determined.
        MinimumDelay -= (uint16)(MinimumDelay * 0.8);
        WeaponDelay = (WeaponDelay < MinimumDelay) ? MinimumDelay : WeaponDelay;
    }
    return WeaponDelay;
}

uint8 CBattleEntity::GetMeleeRange()
{
    return m_ModelSize + 3;
}

int16 CBattleEntity::GetRangedWeaponDelay(bool tp)
{
    TracyZoneScoped;
    CItemWeapon* PRange = (CItemWeapon*)m_Weapons[SLOT_RANGED];
    CItemWeapon* PAmmo = (CItemWeapon*)m_Weapons[SLOT_AMMO];

    // base delay
    int16 delay = 0;

    if (PRange != nullptr && PRange->getDamage() != 0) {
        delay = ((PRange->getDelay() * 60) / 1000);
    }

    delay = (((delay - getMod(Mod::RANGED_DELAY)) * 1000) / 120);

    //apply haste and delay reductions that don't affect tp
    if (!tp)
    {
        delay = (int16)(delay * ((100.0f + getMod(Mod::RANGED_DELAYP)) / 100.0f));
        if (delay == 0)
            delay = 900;
    }
    else if (PRange && PAmmo && PRange->getSkillType() != SKILL_THROWING && PAmmo->getSkillType() != SKILL_THROWING)
    {
        delay += PAmmo->getDelay() / 2;
    }
    return delay;
}

int16 CBattleEntity::GetAmmoDelay()
{
    CItemWeapon* PAmmo = (CItemWeapon*)m_Weapons[SLOT_AMMO];

    int delay = 0;
    if (PAmmo != nullptr && PAmmo->getDamage() != 0) {
        delay = PAmmo->getDelay() / 2;
    }

    return delay;
}

uint16 CBattleEntity::GetMainWeaponDmg()
{
    if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
    {
        // Level sync scaling
        if ((weapon->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            uint16 dmg = weapon->getDamage();
            dmg *= GetMLevel() * 3;
            dmg /= 4;
            dmg /= weapon->getReqLvl();
            return dmg + getMod(Mod::MAIN_DMG_RATING);
        }
        else
            return weapon->getDamage() + getMod(Mod::MAIN_DMG_RATING);
    }
    return 0;
}

uint16 CBattleEntity::GetSubWeaponDmg()
{
    if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]))
    {
        // Level sync scaling
        if ((weapon->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            uint16 dmg = weapon->getDamage();
            dmg *= GetMLevel() * 3;
            dmg /= 4;
            dmg /= weapon->getReqLvl();
            return dmg + getMod(Mod::SUB_DMG_RATING);
        }
        else
            return weapon->getDamage() + getMod(Mod::SUB_DMG_RATING);
    }
    return 0;
}

uint16 CBattleEntity::GetRangedWeaponDmg()
{
    uint16 dmg = 0;
    if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_RANGED]))
    {
        // Level sync scaling
        if ((weapon->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            uint16 scaleddmg = weapon->getDamage();
            scaleddmg *= GetMLevel() * 3;
            scaleddmg /= 4;
            scaleddmg /= weapon->getReqLvl();
            dmg += scaleddmg;
        }
        else
            dmg += weapon->getDamage();
    }
    if (auto ammo = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_AMMO]))
    {
        // Level sync scaling
        if ((ammo->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            uint16 scaleddmg = ammo->getDamage();
            scaleddmg *= GetMLevel() * 3;
            scaleddmg /= 4;
            scaleddmg /= ammo->getReqLvl();
            dmg += scaleddmg;
        }
        else
            dmg += ammo->getDamage();
    }
    return dmg + getMod(Mod::RANGED_DMG_RATING);
}

uint16 CBattleEntity::GetMainWeaponRank()
{
    if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
    {
        if (weapon->getSkillType() == SKILL_HAND_TO_HAND)
            return (weapon->getDamage() + getMod(Mod::MAIN_DMG_RANK) + 3) / 9;
        else
            return (weapon->getDamage() + getMod(Mod::MAIN_DMG_RANK)) / 9;
    }
    return 0;
}

uint16 CBattleEntity::GetSubWeaponRank()
{
    if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]))
    {
        return (weapon->getDamage() + getMod(Mod::SUB_DMG_RANK)) / 9;
    }
    return 0;
}

uint16 CBattleEntity::GetRangedWeaponRank()
{
    if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_RANGED]))
    {
        return (weapon->getDamage() + getMod(Mod::RANGED_DMG_RANK)) / 9;
    }
    return 0;
}

int16 CBattleEntity::AddTPFromSpell(CBattleEntity* PAttacker, uint8 numHits)
{
    // https://ffxiclopedia.fandom.com/wiki/Tactical_Points?oldid=1031494 give 50 tp to players, 100 to mobs
    int16 baseTp = objtype == TYPE_MOB ? 100 : 50;

    // https://ffxiclopedia.fandom.com/wiki/Subtle_Blow?oldid=924414 subtle blow effects spell damage tp given
    float sBlowMult = battleutils::CalculateSubtleBlowMultiplier(PAttacker);
    return addTP((int16)(baseTp * sBlowMult * numHits));
}

int16 CBattleEntity::AddTPFromHit(CBattleEntity* PAttacker, CItemWeapon* weapon, int16 baseTp, float tpMultiplier)
{
    float storeTPMult = GetStoreTPMultiplier();
    float sBlowMult = battleutils::CalculateSubtleBlowMultiplier(PAttacker);

    //mobs hit get basetp+30 whereas pcs (or pcs pets) hit get basetp/3
    if (objtype == TYPE_PC || (objtype == TYPE_PET && PMaster && PMaster->objtype == TYPE_PC))
    {
        baseTp /= 3;

    }
    else if (weapon->getSkillType() == SKILL_HAND_TO_HAND && PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_FOOTWORK) && !PAttacker->StatusEffectContainer->HasStatusEffect(EFFECT_HUNDRED_FISTS))
    {
        baseTp = 93;
    }
    else
    {
        baseTp += 30;
    }

    return addTP((int16)(baseTp * tpMultiplier * sBlowMult * storeTPMult)); //yup store tp counts on hits taken too!
}

/************************************************************************
*                                                                       *
*  Изменяем количество TP сущности	                                    *
*                                                                       *
************************************************************************/

int16 CBattleEntity::addTP(int16 tp)
{
    // When adding TP, we must adjust for Inhibit TP effect, which reduces TP gain.
    if (tp > 0)
    {
        float tpReducePercent = this->getMod(Mod::INHIBIT_TP) / 100.0f;
        tp = (int16)(tp - (tp * tpReducePercent));

        float TPMulti = 1.0;

        if (objtype == TYPE_PC)
        {
            TPMulti = map_config.player_tp_multiplier;
        }
        else if (objtype == TYPE_MOB)
        {
            TPMulti = map_config.mob_tp_multiplier;
        }
        else if (objtype == TYPE_PET)
        {
            if (static_cast<CPetEntity*>(this)->getPetType() != PETTYPE_AUTOMATON || !this->PMaster)
                TPMulti = map_config.mob_tp_multiplier * 3;
            else
                TPMulti = map_config.player_tp_multiplier;
        }

        tp = (int16)(tp * TPMulti);
    }
    if (tp != 0)
    {
        updatemask |= UPDATE_HP;
    }
    
    int16 cap = std::clamp(health.tp + tp, 0, (int)health.modtp);
    tp = health.tp - cap;
    health.tp = cap;
    return abs(tp);
}

/************************************************************************
*																		*
*  Изменяем количество жизней сущности									*
*																		*
************************************************************************/

int32 CBattleEntity::addHP(int32 hp)
{
    if (health.hp == 0 && hp < 0) {
        return 0; //if the entity is already dead, skip the rest to prevent killing it again
    }

    int32 cap = std::clamp(health.hp + hp, 0, GetMaxHP());
    hp = health.hp - cap;
    health.hp = cap;

    // если количество жизней достигает нуля, то сущность умирает

    if (hp > 0)
    {
        battleutils::MakeEntityStandUp(this);
    }

    if (hp != 0)
    {
        updatemask |= UPDATE_HP;
    }

    if (health.hp == 0 && m_unkillable)
    {
        health.hp = 1;
    }

    return abs(hp);
}

int32 CBattleEntity::addMP(int32 mp)
{
    int32 cap = std::clamp(health.mp + mp, 0, GetMaxMP());
    mp = health.mp - cap;
    health.mp = cap;
    if (mp != 0)
    {
        updatemask |= UPDATE_HP;
    }
    return abs(mp);
}

// Added optional breakBind argument in MR !2167
int32 CBattleEntity::takeDamage(int32 amount, CBattleEntity* attacker /* = nullptr*/, ATTACKTYPE attackType /* = ATTACK_NONE*/, DAMAGETYPE damageType /* = DAMAGE_NONE*/, bool breakBind /* = TRUE*/)
{
    TracyZoneScoped;
    if (health.hp <= 0)
    {
        return 0;
    }

    PLastAttacker = attacker;
    this->BattleHistory.lastHitTaken_atkType = attackType;
    PAI->EventHandler.triggerListener("TAKE_DAMAGE", this, amount, attacker, (uint16)attackType, (uint16)damageType);
    this->SetLocalVar("dmgsourceblumagic", 0);
    
    if (this->getMod(Mod::COVERED_MP_FLAG) && amount > 4)
        this->addMP(amount / 5);


    //RoE Damage Taken Trigger
    if (this->objtype == TYPE_PC)
        roeutils::event(ROE_EVENT::ROE_DMGTAKEN, static_cast<CCharEntity*>(this), RoeDatagram("dmg", amount));
    else if (PLastAttacker && PLastAttacker->objtype == TYPE_PC)
        roeutils::event(ROE_EVENT::ROE_DMGDEALT, static_cast<CCharEntity*>(attacker), RoeDatagram("dmg", amount));

    // Took dmg from non ws source, so remove ws kill var
    this->SetLocalVar("weaponskillHit", 0);
        
    if (amount > 0 && attacker)
    {
        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);

        //Added conditional in MR !2167
        if (breakBind)
            battleutils::BindBreakCheck(attacker, this);
    }

    return addHP(-amount);
}

/************************************************************************
*                                                                       *
*  Полные значения характеристик боевой сущности                        *
*                                                                       *
************************************************************************/

uint16 CBattleEntity::STR()
{
    return std::clamp(stats.STR + m_modStat[Mod::STR], 0, 999);
}

uint16 CBattleEntity::DEX()
{
    return std::clamp(stats.DEX + m_modStat[Mod::DEX], 0, 999);
}

uint16 CBattleEntity::VIT()
{
    return std::clamp(stats.VIT + m_modStat[Mod::VIT], 0, 999);
}

uint16 CBattleEntity::AGI()
{
    return std::clamp(stats.AGI + m_modStat[Mod::AGI], 0, 999);
}

uint16 CBattleEntity::INT()
{
    return std::clamp(stats.INT + m_modStat[Mod::INT], 0, 999);
}

uint16 CBattleEntity::MND()
{
    return std::clamp(stats.MND + m_modStat[Mod::MND], 0, 999);
}

uint16 CBattleEntity::CHR()
{
    return std::clamp(stats.CHR + m_modStat[Mod::CHR], 0, 999);
}

uint16 CBattleEntity::ATT()
{
    //TODO: consider which weapon!
    int32 ATT = 8 + m_modStat[Mod::ATT];
    auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]);
    if (weapon && weapon->isTwoHanded())
    {
        ATT += STR() * 3 / 4;
    }
    else
    {
        ATT += STR() / 2;
    }

    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_ENDARK))
        ATT += this->getMod(Mod::ENSPELL_DMG);

    if (this->objtype & TYPE_PC)
    {
        if (weapon)
        {
            ATT += GetSkill(weapon->getSkillType()) + weapon->getILvlSkill();

            // Smite applies when using 2H or H2H weapons
            if (weapon->isTwoHanded() || weapon->isHandToHand())
            {
                ATT += static_cast<int32>(ATT * this->getMod(Mod::SMITE) / 256.f); // Divide smite value by 256
            }
        }
    }
    else if (this->objtype == TYPE_PET && ((CPetEntity*)this)->getPetType() == PETTYPE_AUTOMATON)
    {
        ATT += this->GetSkill(SKILL_AUTOMATON_MELEE);
    }
    return std::max<int16>(0, ATT + (ATT * m_modStat[Mod::ATTP] / 100) +
        std::min<int16>((ATT * m_modStat[Mod::FOOD_ATTP] / 100), m_modStat[Mod::FOOD_ATT_CAP]));
}

uint16 CBattleEntity::RATT(uint8 skill, float distance, uint16 bonusSkill)
{
    auto PWeakness = StatusEffectContainer->GetStatusEffect(EFFECT_WEAKNESS);
    if (PWeakness && PWeakness->GetPower() >= 2)
    {
        return 0;
    }
    if (this->objtype == TYPE_PC)
    {
        CItemEquipment* Rwep = ((CCharEntity*)this)->getEquip(SLOT_RANGED);
        CItemEquipment* Rammo = ((CCharEntity*)this)->getEquip(SLOT_AMMO);
        if (Rwep && ((CItemWeapon*)Rwep)->getSkillType() == SKILL_FISHING)
            return 0; // fishing rods dont offer RATT
        if (Rammo && ((CItemWeapon*)Rammo)->getSkillType() == SKILL_FISHING)
            return 0; // fishing baits dont offer RATT
    }

    uint16 skill_level = GetSkill(skill);
    if (skill == SKILL_AUTOMATON_RANGED)
        skill_level = PMaster->GetSkill(skill) + bonusSkill;
    int32 ATT = 8 + skill_level + bonusSkill + m_modStat[Mod::RATT] + battleutils::GetRangedAttackBonuses(this) + STR() / 2;

    // apply ranged distance variation
    if ((this->objtype == TYPE_PC || // im a PC
        (this->objtype == TYPE_PET && ((CPetEntity*)this)->getPetType() == PETTYPE_AUTOMATON && this->PMaster->objtype == TYPE_PC)) // im an automaton and my master is a PC
        && distance < 999.0f)
        ATT = (int32)((float)ATT * battleutils::GetRangedAttackDistanceCorrection(this, distance));

    return std::max<int16>(0, ATT + (ATT * m_modStat[Mod::RATTP] / 100) +
        std::min<int16>((ATT * m_modStat[Mod::FOOD_RATTP] / 100), m_modStat[Mod::FOOD_RATT_CAP]));
}

uint16 CBattleEntity::RACC(uint8 skill, uint16 bonusSkill)
{
    auto PWeakness = StatusEffectContainer->GetStatusEffect(EFFECT_WEAKNESS);
    if (PWeakness && PWeakness->GetPower() >= 2)
    {
        return 0;
    }
    if (this->objtype == TYPE_PC)
    {
        CItemEquipment* Rwep = ((CCharEntity*)this)->getEquip(SLOT_RANGED);
        CItemEquipment* Rammo = ((CCharEntity*)this)->getEquip(SLOT_AMMO);
        if (Rwep && ((CItemWeapon*)Rwep)->getSkillType() == SKILL_FISHING)
            return 0; // fishing rods dont offer RACC
        if (Rammo && ((CItemWeapon*)Rammo)->getSkillType() == SKILL_FISHING)
            return 0; // fishing baits dont offer RACC
    }

    int skill_level = GetSkill(skill) + bonusSkill;
    if (skill == SKILL_AUTOMATON_RANGED)
        skill_level = PMaster->GetSkill(skill) + bonusSkill;
    uint16 acc = skill_level;
    if (skill_level > 200)
    {
        acc = (uint16)(200 + (skill_level - 200) * 0.9);
    }
    acc += getMod(Mod::RACC);
    acc += battleutils::GetRangedAccuracyBonuses(this);
    acc += AGI() / 2;
    return std::max<int16>(0, acc + std::min<int16>(((100 + getMod(Mod::FOOD_RACCP) * acc) / 100), getMod(Mod::FOOD_RACC_CAP)));
}

uint16 CBattleEntity::ACC(uint8 attackNumber, uint8 offsetAccuracy)
{
    if (this->objtype & TYPE_PC) {
        uint8 skill = 0;
        uint16 iLvlSkill = 0;
        if (attackNumber == 0)
        {
            if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
            {
                skill = weapon->getSkillType();
                iLvlSkill = weapon->getILvlSkill();
                if (skill == SKILL_NONE && GetSkill(SKILL_HAND_TO_HAND) > 0)
                    skill = SKILL_HAND_TO_HAND;
            }
        }
        else if (attackNumber == 1)
        {
            if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]))
            {
                skill = weapon->getSkillType();
                iLvlSkill = weapon->getILvlSkill();
                if (skill == SKILL_NONE && GetSkill(SKILL_HAND_TO_HAND) > 0)
                {
                    auto main_weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]);
                    if (main_weapon && (main_weapon->getSkillType() == SKILL_NONE || main_weapon->getSkillType() == SKILL_HAND_TO_HAND))
                    {
                        skill = SKILL_HAND_TO_HAND;
                    }
                }

            }
        }
        else if (attackNumber == 2)
        {
            if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
            {
                iLvlSkill = weapon->getILvlSkill();
            }
            skill = SKILL_HAND_TO_HAND;
        }
        int16 ACC = GetSkill(skill) + iLvlSkill;
        ACC = (ACC > 200 ? (int16)(((ACC - 200) * 0.9) + 200) : ACC);
        if (auto weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]); weapon && weapon->isTwoHanded() == true)
        {
            ACC += DEX() * 3 / 4;
        }
        else
        {
            ACC += DEX() / 2;
        }
        ACC = (ACC + m_modStat[Mod::ACC] + offsetAccuracy);
        auto PChar = dynamic_cast<CCharEntity *>(this);
        if (PChar)
            ACC += PChar->PMeritPoints->GetMeritValue(MERIT_ACCURACY, PChar);
        ACC = ACC + std::min<int16>((ACC * m_modStat[Mod::FOOD_ACCP] / 100), m_modStat[Mod::FOOD_ACC_CAP]);
        return std::max<int16>(0, ACC);
    }
    else if (this->objtype == TYPE_PET && ((CPetEntity*)this)->getPetType() == PETTYPE_AUTOMATON)
    {
        int16 ACC = this->GetSkill(SKILL_AUTOMATON_MELEE);
        ACC = (ACC > 200 ? (int16)(((ACC - 200) * 0.9) + 200) : ACC);
        ACC += (int16)(DEX() * 0.5);
        ACC += m_modStat[Mod::ACC] + offsetAccuracy;
        ACC = ACC + std::min<int16>((ACC * m_modStat[Mod::FOOD_ACCP] / 100), m_modStat[Mod::FOOD_ACC_CAP]);
        return std::max<int16>(0, ACC);
    }
    else
    {
        int16 ACC = m_modStat[Mod::ACC];
        ACC = ACC + std::min<int16>((ACC * m_modStat[Mod::FOOD_ACCP] / 100), m_modStat[Mod::FOOD_ACC_CAP]) + DEX() / 2; //food mods here for Snatch Morsel
        return std::max<int16>(0, ACC);
    }
}

uint16 CBattleEntity::DEF()
{
    int32 DEF = 1;
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_COUNTERSTANCE, 0))
    {
        DEF = this->VIT() / 2 + this->StatusEffectContainer->GetTotalMinneBonus();
        if (m_modStat[Mod::DEFP] < 0)
            DEF = DEF + (DEF * m_modStat[Mod::DEFP]) / 100;
        return std::max<int16>(0, DEF);
    }

    DEF = 8 + m_modStat[Mod::DEF] + VIT() / 2;
    return std::max<int16>(0, DEF + (DEF * m_modStat[Mod::DEFP] / 100) +
        std::min<int16>((DEF * m_modStat[Mod::FOOD_DEFP] / 100), m_modStat[Mod::FOOD_DEF_CAP]));
}

uint16 CBattleEntity::EVA()
{
    int16 evasion = GetSkill(SKILL_EVASION);

    if (evasion > 200) { //Evasion skill is 0.9 evasion post-200
        evasion = (int16)(200 + (evasion - (int16)200) * 0.9);
    }
    return std::max<int16>(0, (m_modStat[Mod::EVA] + evasion + AGI() / 2));
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

JOBTYPE CBattleEntity::GetMJob()
{
    return m_mjob;
}

uint8 CBattleEntity::GetMLevel()
{
    return m_mlvl;
}

JOBTYPE CBattleEntity::GetSJob()
{
    return m_sjob;
}

uint8 CBattleEntity::GetSLevel()
{
    if (StatusEffectContainer->HasStatusEffect({ EFFECT_OBLIVISCENCE, EFFECT_SJ_RESTRICTION })) { return 0; }
    return m_slvl;
}

void CBattleEntity::SetMJob(uint8 mjob)
{
    TPZ_DEBUG_BREAK_IF(mjob == 0 || mjob >= MAX_JOBTYPE);	// выход за пределы доступных профессий

    m_mjob = (JOBTYPE)mjob;
}

void CBattleEntity::SetSJob(uint8 sjob)
{
    TPZ_DEBUG_BREAK_IF(sjob >= MAX_JOBTYPE);				// выход за пределы доступных профессий

    m_sjob = (JOBTYPE)sjob;
}

void CBattleEntity::SetMLevel(uint8 mlvl)
{
    m_modStat[Mod::DEF] -= m_mlvl + std::clamp(m_mlvl - 50, 0, 10);
    m_mlvl = (mlvl == 0 ? 1 : mlvl);
    m_modStat[Mod::DEF] += m_mlvl + std::clamp(m_mlvl - 50, 0, 10);

    if (this->objtype & TYPE_PC)
        Sql_Query(SqlHandle, "UPDATE char_stats SET mlvl = %u WHERE charid = %u LIMIT 1;", m_mlvl, this->id);
}

void CBattleEntity::SetSLevel(uint8 slvl)
{
    m_slvl = (slvl > (m_mlvl >> 1) ? (m_mlvl == 1 ? 1 : (m_mlvl >> 1)) : slvl);

    if (this->objtype & TYPE_PC)
        Sql_Query(SqlHandle, "UPDATE char_stats SET slvl = %u WHERE charid = %u LIMIT 1;", m_slvl, this->id);
}

/************************************************************************
*																		*
*  Добавляем модификатор												*
*																		*
************************************************************************/

void CBattleEntity::addModifier(Mod type, int16 amount)
{
    if (type == Mod::MOVE)
    {
        //printf("[+] Adding non-item source with MS Mod (Start)\n");
        m_MSNonItemValues.push_back(amount);
        m_modStat[type] = CalculateMSFromSources();
        //printf("[+] Adding non-item source with MS Mod (End)\n");
    }
    else
    {
        m_modStat[type] += amount;
    }
}

/************************************************************************
*																		*
*  Добавляем модификаторы												*
*																		*
************************************************************************/

void CBattleEntity::addModifiers(std::vector<CModifier> *modList)
{
    for (auto modifier : *modList)
    {
        if (modifier.getModID() == Mod::MOVE)
        {
            addModifier(modifier.getModID(), modifier.getModAmount()); // Calculations in addModifier already, don't duplicate
        }
        else
        {
            m_modStat[modifier.getModID()] += modifier.getModAmount();
        }
    }
}

int16 CBattleEntity::CalculateMSFromSources()
{
    TracyZoneScoped;
    int16 highestItemPositiveValue = 0;
    int16 highestNonItemPositve = 0;
    int16 totalItemReducedValue = 0;
    int16 totalNonItemReducedValue = 0;

    //printf("    [*] Entered CalculateMSFromSources()\n");
    //printf("    [*] Size of m_MSItemValues: %i\n", m_MSItemValues.size());
    //printf("    [*] Size of m_MSNonItemValues: %i\n", m_MSNonItemValues.size());

    for (uint16 i = 0; i < m_MSNonItemValues.size(); i++)
    {
        if (m_MSNonItemValues[i] >= 0)
        {
            if (m_MSNonItemValues[i] > highestNonItemPositve)
            {
                highestNonItemPositve = m_MSNonItemValues[i];
            }
        }
        else
        {
            totalNonItemReducedValue += m_MSNonItemValues[i];
        }
    }
    
    for (uint16 i = 0; i < m_MSItemValues.size(); i++)
    {
        if (m_MSItemValues[i] >= 0)
        {
            if (m_MSItemValues[i] > highestItemPositiveValue)
            {
                highestItemPositiveValue = m_MSItemValues[i];
            }
        }
        else
        {
            totalItemReducedValue += m_MSItemValues[i];
        }
    }

    //printf("    [*] totalItemReducedValue = %i  -  highestItemPositiveValue = %i\n",totalItemReducedValue , highestItemPositiveValue);
    //printf("    [*] totalNonItemReducedValue = %i  -  highestNonItemPositve = %i\n",totalNonItemReducedValue , highestNonItemPositve);
    //printf("    [*] Leaving CalculateMSFromSources()\n");

    return (highestItemPositiveValue + totalItemReducedValue) + (highestNonItemPositve + totalNonItemReducedValue);
}


void CBattleEntity::addEquipModifiers(std::vector<CModifier> *modList, uint8 itemLevel, uint8 slotid)
{
    TracyZoneScoped;
    if (GetMLevel() >= itemLevel)
    {
        for (uint16 i = 0; i < modList->size(); ++i)
        {
            if (slotid == SLOT_SUB)
            {
                if (modList->at(i).getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] += modList->at(i).getModAmount();
                }
                else
                {
                    m_modStat[modList->at(i).getModID()] += modList->at(i).getModAmount();
                }
            }
            else
            {
                // Add item with movement speed and prevent stacking
                if (modList->at(i).getModID() == Mod::MOVE)
                {
                    //printf("[+] Adding item with MS Mod (Start)\n");
                    m_MSItemValues.push_back(modList->at(i).getModAmount());
                    m_modStat[modList->at(i).getModID()] = CalculateMSFromSources();
                    //printf("[-] Adding item with MS Mod (Done)\n");
                }
                else
                {
                    m_modStat[modList->at(i).getModID()] += modList->at(i).getModAmount();
                }
            }
        }
    }
    else
    {
        for (uint16 i = 0; i < modList->size(); ++i)
        {
            int16 modAmount = GetMLevel() * modList->at(i).getModAmount();
            switch (modList->at(i).getModID())
            {
                case Mod::DEF:
                case Mod::MAIN_DMG_RATING:
                case Mod::SUB_DMG_RATING:
                case Mod::RANGED_DMG_RATING:
                    modAmount *= 3;
                    modAmount /= 4;
                    break;
                case Mod::HP:
                case Mod::MP:
                    modAmount /= 2;
                    break;
                case Mod::STR:
                case Mod::DEX:
                case Mod::VIT:
                case Mod::AGI:
                case Mod::INT:
                case Mod::MND:
                case Mod::CHR:
                case Mod::ATT:
                case Mod::RATT:
                case Mod::ACC:
                case Mod::RACC:
                case Mod::MATT:
                case Mod::MACC:
                    modAmount /= 3;
                    break;
                default:
                    modAmount = 0;
                    break;
            }
            modAmount /= itemLevel;
            if (slotid == SLOT_SUB)
            {
                if (modList->at(i).getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] += modAmount;
                }
                else
                {
                    m_modStat[modList->at(i).getModID()] += modAmount;
                }
            }
            else
            {
                m_modStat[modList->at(i).getModID()] += modAmount;
            }
        }
    }
}

/************************************************************************
*																		*
*  Устанавливаем модификатор											*
*																		*
************************************************************************/

void CBattleEntity::setModifier(Mod type, int16 amount)
{
    m_modStat[type] = amount;
}

/************************************************************************
*																		*
*  Устанавливаем модификаторы											*
*																		*
************************************************************************/

void CBattleEntity::setModifiers(std::vector<CModifier> *modList)
{
    for (uint16 i = 0; i < modList->size(); ++i)
    {
        m_modStat[modList->at(i).getModID()] = modList->at(i).getModAmount();
    }
}

/************************************************************************
*																		*
*  Удаляем модификатор													*
*																		*
************************************************************************/

void CBattleEntity::delModifier(Mod type, int16 amount)
{
    if (type == Mod::MOVE)
    {
        //printf("[+] Removing non-item source with MS Mod (Start)\n");
        for (uint16 x = 0; x < m_MSNonItemValues.size(); x++)
        {
            if (m_MSNonItemValues[x] == amount)
            {
                 m_MSNonItemValues.erase(m_MSNonItemValues.begin() + x);
                break;
            }
        }

        m_modStat[type] = CalculateMSFromSources();
        //printf("[+] Removing non-item source with MS Mod (End)\n");
    }
    else
    {
        m_modStat[type] -= amount;
    }
}

void CBattleEntity::saveModifiers()
{
    m_modStatSave = m_modStat;
}

void CBattleEntity::restoreModifiers()
{
    m_modStat = m_modStatSave;
}

/************************************************************************
*																		*
*  Удаляем модификаторы													*
*																		*
************************************************************************/

void CBattleEntity::delModifiers(std::vector<CModifier> *modList)
{
    for (uint16 i = 0; i < modList->size(); ++i)
    {
        if (modList->at(i).getModID() == Mod::MOVE)
        {
            delModifier(modList->at(i).getModID(), modList->at(i).getModAmount()); // Calculations in delModifier already, don't duplicate
        }
        else
        {
            m_modStat[modList->at(i).getModID()] -= modList->at(i).getModAmount();
        }
    }
}

void CBattleEntity::delEquipModifiers(std::vector<CModifier>* modList, uint8 itemLevel, uint8 slotid)
{
    TracyZoneScoped;
    if (GetMLevel() >= itemLevel)
    {
        for (uint16 i = 0; i < modList->size(); ++i)
        {
            if (slotid == SLOT_SUB)
            {
                if (modList->at(i).getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] -= modList->at(i).getModAmount();
                }
                else
                {
                    m_modStat[modList->at(i).getModID()] -= modList->at(i).getModAmount();
                }
            }
            else
            {
                // Remove item with movement speed and prevent stacking
                if (modList->at(i).getModID() == Mod::MOVE)
                {
                    //printf("[+] Removing item with MS Mod (Start)\n");

                    for (uint16 x = 0; x < m_MSItemValues.size(); x++)
                    {
                        if (m_MSItemValues[x] == modList->at(i).getModAmount())
                        {
                            m_MSItemValues.erase(m_MSItemValues.begin() + x);
                            break;
                        }
                    }

                    m_modStat[modList->at(i).getModID()] = CalculateMSFromSources();
                    //printf("[+] Removing item with MS Mod (Done)\n");
                }
                else
                {
                    m_modStat[modList->at(i).getModID()] -= modList->at(i).getModAmount();
                }
            }
        }
    }
    else
    {
        for (uint16 i = 0; i < modList->size(); ++i)
        {
            int16 modAmount = GetMLevel() * modList->at(i).getModAmount();
            switch (modList->at(i).getModID())
            {
                case Mod::DEF:
                case Mod::MAIN_DMG_RATING:
                case Mod::SUB_DMG_RATING:
                case Mod::RANGED_DMG_RATING:
                    modAmount *= 3;
                    modAmount /= 4;
                    break;
                case Mod::HP:
                case Mod::MP:
                    modAmount /= 2;
                    break;
                case Mod::STR:
                case Mod::DEX:
                case Mod::VIT:
                case Mod::AGI:
                case Mod::INT:
                case Mod::MND:
                case Mod::CHR:
                case Mod::ATT:
                case Mod::RATT:
                case Mod::ACC:
                case Mod::RACC:
                case Mod::MATT:
                case Mod::MACC:
                    modAmount /= 3;
                    break;
                default:
                    modAmount = 0;
                    break;
            }
            modAmount /= itemLevel;
            if (slotid == SLOT_SUB)
            {
                if (modList->at(i).getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] -= modAmount;
                }
                else
                {
                    m_modStat[modList->at(i).getModID()] -= modAmount;
                }
            }
            else
            {
                m_modStat[modList->at(i).getModID()] -= modAmount;
            }
        }
    }
}

/************************************************************************
*																		*
*  Получаем текущее значение указанного модификатора					*
*																		*
************************************************************************/

int16 CBattleEntity::getMod(Mod modID)
{
    return m_modStat[modID];
}

void CBattleEntity::addPetModifier(Mod type, PetModType petmod, int16 amount)
{
    m_petMod[petmod][type] += amount;

    if (PPet && petutils::CheckPetModType(PPet, petmod))
    {
        PPet->addModifier(type, amount);
        PPet->UpdateHealth();
    }
}

void CBattleEntity::setPetModifier(Mod type, PetModType petmod, int16 amount)
{
    m_petMod[petmod][type] = amount;

    if (PPet && petutils::CheckPetModType(PPet, petmod))
    {
        PPet->setModifier(type, amount);
        PPet->UpdateHealth();
    }
}

void CBattleEntity::delPetModifier(Mod type, PetModType petmod, int16 amount)
{
    m_petMod[petmod][type] -= amount;

    if (PPet && petutils::CheckPetModType(PPet, petmod))
    {
        PPet->delModifier(type, amount);
        PPet->UpdateHealth();
    }
}

void CBattleEntity::addPetModifiers(std::vector<CPetModifier> *modList)
{
    for (auto modifier : *modList)
    {
        addPetModifier(modifier.getModID(), modifier.getPetModType(), modifier.getModAmount());
    }
}

void CBattleEntity::delPetModifiers(std::vector<CPetModifier> *modList)
{
    for (auto modifier : *modList)
    {
        delPetModifier(modifier.getModID(), modifier.getPetModType(), modifier.getModAmount());
    }
}

void CBattleEntity::applyPetModifiers(CPetEntity* PPet)
{
    for (auto modtype : m_petMod)
    {
        if (petutils::CheckPetModType(PPet, modtype.first))
        {
            for (auto mod : modtype.second)
            {
                PPet->addModifier(mod.first, mod.second);
                PPet->UpdateHealth();
            }
        }
    }
}


void CBattleEntity::removePetModifiers(CPetEntity* PPet)
{
    for (auto modtype : m_petMod)
    {
        if (petutils::CheckPetModType(PPet, modtype.first))
        {
            for (auto mod : modtype.second)
            {
                PPet->delModifier(mod.first, mod.second);
                PPet->UpdateHealth();
            }
        }
    }
}

/************************************************************************
*																		*
*  Текущая величина умения (не максимальная, а ограниченная уровнем)	*
*																		*
************************************************************************/

uint16 CBattleEntity::GetSkill(uint16 SkillID)
{
    if (SkillID < MAX_SKILLTYPE)
    {
        return WorkingSkills.skill[SkillID] & 0x7FFF;
    }
    return 0;
}

void CBattleEntity::addTrait(CTrait* PTrait)
{
    TraitList.push_back(PTrait);
    addModifier(PTrait->getMod(), PTrait->getValue());
}

void CBattleEntity::delTrait(CTrait* PTrait)
{
    delModifier(PTrait->getMod(), PTrait->getValue());
    TraitList.erase(std::remove(TraitList.begin(), TraitList.end(), PTrait), TraitList.end());
}

bool CBattleEntity::hasTrait(CTrait* PTrait)
{
    //ShowDebug("Ohhh checking to see if I have trait with ID %u and rank %u\n", PTrait->getID(), PTrait->getRank());
    if (!TraitList.empty())
        return std::find(TraitList.begin(), TraitList.end(), PTrait) != TraitList.end();
    else
        return false;
}

bool CBattleEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (targetFlags & TARGET_ENEMY)
    {
        if (!isDead())
        {
            // Teams PVP
            if (allegiance >= ALLEGIANCE_WYVERNS &&
                PInitiator->allegiance >= ALLEGIANCE_WYVERNS)
            {
                return allegiance != PInitiator->allegiance;
            }

            // Nation PVP
            if ((allegiance >= ALLEGIANCE_SAN_DORIA && allegiance <= ALLEGIANCE_WINDURST) &&
                (PInitiator->allegiance >= ALLEGIANCE_SAN_DORIA && PInitiator->allegiance <= ALLEGIANCE_WINDURST))
            {
                return allegiance != PInitiator->allegiance;
            }

            // PVE
            if (allegiance <= ALLEGIANCE_PLAYER &&
                PInitiator->allegiance <= ALLEGIANCE_PLAYER)
            {
                return allegiance != PInitiator->allegiance;
            }

            return false;
        }
    }

    if ((targetFlags & TARGET_SELF) && (this == PInitiator || (PInitiator->objtype == TYPE_PET &&
        static_cast<CPetEntity*>(PInitiator)->getPetType() == PETTYPE_AUTOMATON && this == PInitiator->PMaster)))
    {
        return true;
    }

    return false;
}

bool CBattleEntity::CanUseSpell(CSpell* PSpell)
{
    return spell::CanUseSpell(this, PSpell);
}

void CBattleEntity::Spawn()
{
    animation = ANIMATION_NONE;
    HideName(false);
    CBaseEntity::Spawn();
    m_OwnerID.clean();
}

void CBattleEntity::Die()
{
    if (CBaseEntity* PKiller = GetEntity(m_OwnerID.targid))
    {
        static_cast<CBattleEntity*>(PKiller)->ForAlliance([this](CBattleEntity* PMember){
            CCharEntity* member = static_cast<CCharEntity*>(PMember);
            if (member->PClaimedMob == this)
            {
                member->PClaimedMob = nullptr;
            }
        });
        PAI->EventHandler.triggerListener("DEATH", this, PKiller);
    }
    else
    {
        PAI->EventHandler.triggerListener("DEATH", this);
    }
    SetBattleTargetID(0);
}

void CBattleEntity::OnDeathTimer()
{}

void CBattleEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    TracyZoneScoped;
    auto PSpell = state.GetSpell();
    auto PActionTarget = static_cast<CBattleEntity*>(state.GetTarget());
    CBattleEntity* POriginalTarget = PActionTarget;
    bool IsMagicCovered= false;
    bool cover = false;

    if (!PActionTarget) {
        return;
    }
    if (PActionTarget->isSuperJumped)
    {
        return OnCastInterrupted(state, action, MSGBASIC_IS_INTERRUPTED);
    }

    if (this->objtype == TYPE_MOB && PActionTarget->StatusEffectContainer->HasStatusEffect(EFFECT_COVER) && PActionTarget->StatusEffectContainer->GetStatusEffect(EFFECT_COVER)->GetPower() & 4)
    {
        auto PCoverTarget = battleutils::getCoverTarget(PActionTarget, this);
        if (PCoverTarget)
        {
            PActionTarget = PCoverTarget;
            if (PCoverTarget->StatusEffectContainer->HasStatusEffect(EFFECT_COVER) && PCoverTarget->StatusEffectContainer->GetStatusEffect(EFFECT_COVER)->GetPower() & 2)
                PCoverTarget->setModifier(Mod::COVERED_MP_FLAG, 1);
            cover = true;
        }
    }

    luautils::OnSpellPrecast(this, PSpell);

    state.SpendCost();

    bool doEnmityAndClaim = true;

    // remove effects based on spell cast first
    int16 effectFlags = EFFECTFLAG_INVISIBLE | EFFECTFLAG_MAGIC_BEGIN;

    if (PSpell->canTargetEnemy())
    {
        effectFlags |= EFFECTFLAG_DETECTABLE;
    }

    StatusEffectContainer->DelStatusEffectsByFlag(effectFlags);

    PAI->TargetFind->reset();

    // setup special targeting flags
    // can this spell target the dead?

    uint8 flags = FINDFLAGS_NONE;
    if (PSpell->getValidTarget() & TARGET_PLAYER_DEAD)
    {
        flags |= FINDFLAGS_DEAD;
    }
    if (PSpell->getFlag() & SPELLFLAG_HIT_ALL)
    {
        flags |= FINDFLAGS_HIT_ALL;
    }
    uint8 aoeType = battleutils::GetSpellAoEType(this, PSpell);
    AOERADIUS radiusType = (PSpell->getFlag() & SPELLFLAG_ATTACKER_RADIUS) != 0 ? AOERADIUS_ATTACKER : AOERADIUS_TARGET;

    if (aoeType == SPELLAOE_RADIAL)
    {
        float distance = spell::GetSpellRadius(PSpell, this);

        PAI->TargetFind->findWithinArea(PActionTarget, radiusType, distance, flags);
    }
    else if (aoeType == SPELLAOE_CONAL)
    {
        float radius = spell::GetSpellRadius(PSpell, this);
        float angle = spell::GetSpellConeAngle(PSpell, this);

        PAI->TargetFind->findWithinCone(PActionTarget, radiusType, radius, angle, flags);
    }
    else
    {
        if (this->objtype == TYPE_MOB && PActionTarget->objtype == TYPE_PC)
        {
            CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PActionTarget, this);
            IsMagicCovered = battleutils::IsMagicCovered((CCharEntity*) PCoverAbilityUser);

            if (IsMagicCovered)
            {
                PActionTarget = PCoverAbilityUser;
            }
        }
        // only add target
        PAI->TargetFind->findSingleTarget(PActionTarget, flags);
    }

    auto totalTargets = (uint16)PAI->TargetFind->m_targets.size();

    PSpell->setTotalTargets(totalTargets);

    action.id = id;
    action.actiontype = ACTION_MAGIC_FINISH;
    action.actionid = static_cast<uint16>(PSpell->getID());
    action.recast = state.GetRecast();
    action.spellgroup = PSpell->getSpellGroup();

    uint16 msg = MSGBASIC_NONE;

    for (auto PTarget : PAI->TargetFind->m_targets)
    {
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();

        actionTarget.reaction = REACTION_NONE;
        actionTarget.speceffect = SPECEFFECT_NONE;
        actionTarget.animation = PSpell->getAnimationID();
        actionTarget.param = 0;
        actionTarget.messageID = MSGBASIC_NONE;

        auto ce = PSpell->getCE();
        auto ve = PSpell->getVE();

        // Super Jump and Super Climb
        if (PTarget->isSuperJumped)
        {
            actionTarget.messageID = MSGBASIC_MAGIC_NO_EFFECT;
            //actionTarget.animation = ANIMATION_NONE; a really weird effect
            continue;
        }

        // Take all shadows
        if (PSpell->canTargetEnemy() && (aoeType > SPELLAOE_NONE || (PSpell->getFlag() & SPELLFLAG_WIPE_SHADOWS)))
        {
            PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_BLINK);
            PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_COPY_IMAGE);
        }

        // TODO: this is really hacky and should eventually be moved into lua, and spellFlags should probably be in the spells table..
        if (PSpell->canHitShadow() && aoeType == SPELLAOE_NONE
            && battleutils::IsAbsorbByShadow(PTarget, this)
            && !(PSpell->getFlag() & SPELLFLAG_IGNORE_SHADOWS))
        {
            // take shadow
            msg = MSGBASIC_SHADOW_ABSORB;
            actionTarget.param = 1;
            ve = 0;
            ce = 0;
        }
        else
        {
            actionTarget.param = luautils::OnSpellCast(this, PTarget, PSpell);

            // Remove Saboteur
            if (PSpell->getSkillType() == SKILLTYPE::SKILL_ENFEEBLING_MAGIC)
            {
                StatusEffectContainer->DelStatusEffect(EFFECT_SABOTEUR);
            }
            if (msg == MSGBASIC_NONE)
            {
                msg = PSpell->getMessage();
            }
            else
            {
                msg = PSpell->getAoEMessage();
            }
        }

        if (actionTarget.animation == 122)
        { // Teleport spells don't target unqualified members
            if (PSpell->getMessage() == MSGBASIC_NONE)
            {
                actionTarget.animation = 0; // stop target from going invisible
                if (PTarget != PActionTarget)
                {
                    action.actionLists.pop_back();
                }
                else
                { // set this message in anticipation of nobody having the gate crystal
                    actionTarget.messageID = MSGBASIC_MAGIC_NO_EFFECT;
                }
                continue;
            }
            if (msg == MSGBASIC_MAGIC_TELEPORT && PTarget != PActionTarget)
            { // reset the no effect message above if somebody has gate crystal
                action.actionLists[0].actionTargets[0].messageID = MSGBASIC_NONE;
            }
        }
        actionTarget.messageID = msg;

        if (IsMagicCovered)
        {
            state.ApplyMagicCoverEnmity(POriginalTarget, PActionTarget, (CMobEntity*)this);
        }
        else
        {
            if (ce == 0 && ve == 0 && PSpell->getSpellGroup() == 5) // summoning magic... odin and atomos
                doEnmityAndClaim = false;

            if (doEnmityAndClaim)
                state.ApplyEnmity(PTarget, ce, ve);
        }

        if (PTarget->objtype == TYPE_MOB && msg != MSGBASIC_SHADOW_ABSORB) // If message isn't the shadow loss message, because I had to move this outside of the above check for it.
        {
            luautils::OnMagicHit(this, PTarget, PSpell);

            if (PSpell->getSpellGroup() == SPELLGROUP_BLUE && ((CBlueSpell*)PSpell)->isPhysical() && msg != MSGBASIC_MAGIC_FAIL)
            {
                // ToDo Regurgitation is a magical spell that has bind + knockback
                actionTarget.reaction = REACTION::REACTION_HIT;
                actionTarget.speceffect = SPECEFFECT::SPECEFFECT_RECOIL;
                actionTarget.knockback = ((CBlueSpell*)PSpell)->getKnockback();
            }
        }
    }
    this->StatusEffectContainer->DelStatusEffect(EFFECT_CONVERGENCE);
    if ((!(PSpell->isHeal()) || PSpell->tookEffect()) && PActionTarget->isAlive())
    {
        if (objtype != TYPE_PET && doEnmityAndClaim)
        {
            battleutils::ClaimMob(PActionTarget, this);
        }
    }

    // Pixie cures should not remove players' sneak/invis/deo
    // No need to check for raise spell because dead players can't have those effects
    if ((this->allegiance != PActionTarget->allegiance) && (!PSpell->isCure()))
    {
        // Should not be removed by AoE effects that don't target the player or
        // buffs cast by other players or mobs.
        PActionTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    }

    if (cover)
        PActionTarget->setModifier(Mod::COVERED_MP_FLAG, 0);

    this->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_MAGIC_END);
    if (PSpell->isCure())
        this->StatusEffectContainer->DelStatusEffect(EFFECT_DIVINE_SEAL);
}

void CBattleEntity::OnCastInterrupted(CMagicState& state, action_t& action, MSGBASIC_ID msg)
{
    CSpell* PSpell = state.GetSpell();
    if (PSpell)
    {
        action.id = id;
        action.actiontype = ACTION_MAGIC_INTERRUPT;
        action.actionid = static_cast<uint16>(PSpell->getID());
        action.spellgroup = PSpell->getSpellGroup();

        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.messageID = 0;
        actionTarget.animation = PSpell->getAnimationID();

        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, state.GetTarget() ? state.GetTarget() : this, 0, 0, msg));
    }
}

void CBattleEntity::OnCastStarting(CMagicState& state)
{
    CSpell* PSpell = state.GetSpell();
    luautils::OnCastStarting(this, PSpell);
}

void CBattleEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    auto PWeaponskill = state.GetSkill();

    action.id = id;
    action.actiontype = ACTION_WEAPONSKILL_FINISH;
    action.actionid = PWeaponskill->getID();
}

bool CBattleEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    TracyZoneScoped;
    if (this->PMaster != nullptr && this->PMaster->objtype == TYPE_PC && !static_cast<CCharEntity*>(this->PMaster)->IsMobOwner(PTarget))
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);

        PAI->Disengage();
        return false;
    }
    if (this->objtype == TYPE_MOB)
    {
        CMobEntity* PMob = (CMobEntity*)this;
        if (!PAI->GetController()->IsAutoAttackEnabled())
        {
            return false;
        }
        else if (distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize > GetMeleeRange())
        {
            if (!PMob->speed || !(PMob->PAI->PathFind->IsFollowingPath() || PMob->PAI->PathFind->IsFollowingScriptedPath()))
                return false; // i must be chasing and not bound

            float bonusRange = 3;
            if (PTarget->speed >= PMob->speed)
                bonusRange = PMob->speed / PTarget->speed * 3;

            // attempt to hit a running target, increase range slightly
            if (std::chrono::system_clock::now() > PMob->m_NextSlidingHit && distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize < GetMeleeRange() + bonusRange)
            {
                std::chrono::duration delay = std::chrono::milliseconds(PMob->GetWeaponDelay(false));
                if (PMob->m_Type & MOBTYPE_NOTORIOUS || PMob->m_Type & MOBTYPE_BATTLEFIELD || PMob->m_Type & MOBTYPE_EVENT)
                {
                    delay = std::chrono::milliseconds(tpzrand::GetRandomNumber(delay.count()*2, delay.count()*3));
                }
                else
                {
                    delay = std::chrono::milliseconds(tpzrand::GetRandomNumber(delay.count()*3, delay.count()*5));
                }
                PMob->m_NextSlidingHit = std::chrono::system_clock::now() + delay;
                return true;
            }
            return false;
        }
    }
    else
    {
        if ((distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize) > GetMeleeRange() || !PAI->GetController()->IsAutoAttackEnabled())
        {
            return false;
        }
    }
    return true;
}

void CBattleEntity::OnDisengage(CAttackState& s)
{
    m_battleTarget = 0;
    if (animation == ANIMATION_ATTACK)
    {
        animation = ANIMATION_NONE;
    }
    updatemask |= UPDATE_HP;
    PAI->EventHandler.triggerListener("DISENGAGE", this);
}

void CBattleEntity::OnChangeTarget(CBattleEntity* PTarget)
{
}

CBattleEntity* CBattleEntity::GetBattleTarget()
{
    return static_cast<CBattleEntity*>(GetEntity(GetBattleTargetID()));
}

bool CBattleEntity::OnAttack(CAttackState& state, action_t& action)
{
    TracyZoneScoped;
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    bool cover = false;

    if (this->objtype == TYPE_MOB)
    {
        CMobEntity* PMob = (CMobEntity*)this;
        if (charutils::CheckMob(PTarget->m_mlvl, PMob->m_mlvl) == EMobDifficulty::TooWeak)
        {
            PMob->m_ExpPenalty = ((PMob->m_ExpPenalty + map_config.pl_penalty) < UINT16_MAX-1) ? PMob->m_ExpPenalty + map_config.pl_penalty : UINT16_MAX-1;
        }

        auto PCoverTarget = battleutils::getCoverTarget(PTarget, this);
        if (PCoverTarget)
        {
            PTarget = PCoverTarget;
            if (PCoverTarget->StatusEffectContainer->HasStatusEffect(EFFECT_COVER) && PCoverTarget->StatusEffectContainer->GetStatusEffect(EFFECT_COVER)->GetPower() & 2)
                PCoverTarget->setModifier(Mod::COVERED_MP_FLAG, 1);
            cover = true;
        }
    }

    if (PTarget->objtype == TYPE_PC)
    {
        // TODO: Should not be removed by AoE effects that don't target the player.
        PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    }

    if (battleutils::IsParalyzed(this))
    {
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, PTarget, 0, 0, MSGBASIC_IS_PARALYZED));
        if (cover)
            PTarget->setModifier(Mod::COVERED_MP_FLAG, 0);
        return false;
    }
    if (battleutils::IsIntimidated(this, PTarget))
    {
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, PTarget, 0, 0, MSGBASIC_IS_INTIMIDATED));
        if (cover)
            PTarget->setModifier(Mod::COVERED_MP_FLAG, 0);
        return false;
    }

    // Create a new attack round.
    CAttackRound attackRound(this, PTarget);

    action.actiontype = ACTION_ATTACK;
    action.id = this->id;
    actionList_t& list = action.getNewActionList();

    list.ActionTargetID = PTarget->id;

    CBattleEntity* POriginalTarget = PTarget;

    
    bool tredecim = false;
    if (this->objtype == TYPE_PC && ((CCharEntity*)this)->getEquip(SLOT_MAIN) != nullptr && (((CCharEntity*)this)->getEquip(SLOT_MAIN))->getID() == 18052)
        tredecim = true;
    
    /////////////////////////////////////////////////////////////////////////
    //	Start of the attack loop.
    /////////////////////////////////////////////////////////////////////////
    while (attackRound.GetAttackSwingCount() && !(PTarget->isDead()))
    {
        actionTarget_t& actionTarget = list.getNewActionTarget();
        // Reference to the current swing.
        CAttack& attack = attackRound.GetCurrentAttack();

        if (tredecim)
            (((CCharEntity*)this)->m_hitCounter)++;

        // Set the swing animation.
        actionTarget.animation = attack.GetAnimationID();

        if (attack.CheckCover())
        {
            PTarget = attackRound.GetCoverAbilityUserEntity();
            list.ActionTargetID = PTarget->id;
        }

        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_DODGE, 0) || PTarget->isSuperJumped)
        {
            actionTarget.messageID = 32;
            actionTarget.reaction = REACTION_EVADE;
            actionTarget.speceffect = SPECEFFECT_NONE;
        }
        else if ((tpzrand::GetRandomNumber(100) < attack.GetHitRate() || attackRound.GetSATAOccured()) &&
                 !PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_ALL_MISS))
        {
            // attack hit, try to be absorbed by shadow unless it is a SATA attack round
            
            if (!(attackRound.GetSATAOccured()) && attack.IsParried())
            {
                actionTarget.messageID = 70;
                actionTarget.reaction = REACTION_PARRY;
                actionTarget.speceffect = SPECEFFECT_NONE;
                battleutils::HandleTacticalParry(PTarget);
                battleutils::HandleIssekiganEnmityBonus(PTarget, this);
            }
            else if (!(attackRound.GetSATAOccured()) && battleutils::IsAbsorbByShadow(PTarget, this))
            {
                actionTarget.messageID = 0;
                actionTarget.reaction = REACTION_EVADE;
                attack.SetEvaded(true);
                PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE_SELF, new CMessageBasicPacket(PTarget, PTarget, 0, 1, 31));
            }
            else if (attack.CheckAnticipated() || attack.CheckCounter())
            {
                if (attack.IsAnticipated())
                {
                    actionTarget.messageID = 30;
                    actionTarget.reaction = REACTION_EVADE;
                    actionTarget.speceffect = SPECEFFECT_NONE;
                }
                if (attack.IsCountered())
                {
                    actionTarget.reaction = REACTION_EVADE;
                    actionTarget.speceffect = SPECEFFECT_NONE;
                    actionTarget.param = 0;
                    actionTarget.messageID = 0;
                    actionTarget.spikesEffect = SUBEFFECT_COUNTER;
                    if (battleutils::IsAbsorbByShadow(this, PTarget))
                    {
                        actionTarget.spikesParam = 1;
                        actionTarget.spikesMessage = MSGBASIC_COUNTER_ABS_BY_SHADOW;
                    }
                    else
                    {
                        int16 naturalh2hDMG = 0;
                        if (auto targ_weapon = dynamic_cast<CItemWeapon*>(PTarget->m_Weapons[SLOT_MAIN]);
                           (targ_weapon && targ_weapon->getSkillType() == SKILL_HAND_TO_HAND) && PTarget->objtype != TYPE_MOB)
                        {
                            naturalh2hDMG = (int16)((PTarget->GetSkill(SKILL_HAND_TO_HAND) * 0.11f) + 3);
                        }

                        float DamageRatio = battleutils::GetDamageRatio(PTarget, this, attack.IsCritical(), 0.f);
                        auto damage = (int32)(PTarget->GetMainWeaponDmg() + naturalh2hDMG + battleutils::GetFSTR(PTarget, this, SLOT_MAIN));
                        damage = (int32)((float)damage * DamageRatio);
                        actionTarget.spikesParam = battleutils::TakePhysicalDamage(PTarget, this, attack.GetAttackType(), damage, false, SLOT_MAIN, 1, nullptr, true, false, true);
                        actionTarget.spikesMessage = 33;
                        if (PTarget->objtype == TYPE_PC)
                        {
                            auto targ_weapon = dynamic_cast<CItemWeapon*>(PTarget->m_Weapons[SLOT_MAIN]);
                            uint8 skilltype = (targ_weapon == nullptr ? SKILL_HAND_TO_HAND : targ_weapon->getSkillType());
                            charutils::TrySkillUP((CCharEntity*)PTarget, (SKILLTYPE)skilltype, GetMLevel());
                        } // In case the Automaton can counter
                        else if (PTarget->objtype == TYPE_PET && PTarget->PMaster && PTarget->PMaster->objtype == TYPE_PC &&
                            static_cast<CPetEntity*>(PTarget)->getPetType() == PETTYPE_AUTOMATON)
                        {
                            puppetutils::TrySkillUP((CAutomatonEntity*)PTarget, SKILL_AUTOMATON_MELEE, GetMLevel());
                        }
                    }
                }
            }
            else
            {
                // Set this attack's critical flag.
                attack.SetCritical(tpzrand::GetRandomNumber(100) < battleutils::GetCritHitRate(this, PTarget, !attack.IsFirstSwing()));
                if (tredecim && ((CCharEntity*)this)->m_hitCounter > 12)
                {
                    ((CCharEntity*)this)->m_hitCounter = 0;
                    attack.SetCritical(true);
                }

                // Critical hit.
                if (attack.IsCritical())
                {
                    actionTarget.reaction = REACTION_HIT;
                    actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
                    actionTarget.messageID = attack.GetAttackType() == PHYSICAL_ATTACK_TYPE::DAKEN ? 353 : 67;

                    if (PTarget->objtype == TYPE_MOB)
                    {
                        // Binding
                        luautils::OnCriticalHit(PTarget, this);
                    }
                }
                // Not critical hit.
                else
                {
                    actionTarget.reaction = REACTION_HIT;
                    actionTarget.speceffect = SPECEFFECT_HIT;
                    actionTarget.messageID = attack.GetAttackType() == PHYSICAL_ATTACK_TYPE::DAKEN ? 352 : 1;
                }

                // Guarded. TODO: Stuff guards that shouldn't.
                if (attack.IsGuarded())
                {
                    actionTarget.reaction = REACTION_GUARD;
                    battleutils::HandleTacticalGuard(PTarget);
                }

                // Apply Feint
                if (CStatusEffect* PFeintEffect = StatusEffectContainer->GetStatusEffect(EFFECT_FEINT))
                {
                    uint16 power = (PTarget->EVA() / 20) * 10; // ensures power is a multiple of 10 to evenly die out over the 10 ticks
                    if (power > 0)
                        PTarget->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_EVASION_DOWN, EFFECT_EVASION_DOWN, power, 3, 30, 0, power/10));
                    StatusEffectContainer->DelStatusEffect(EFFECT_FEINT);
                }

                // Process damage.
                attack.ProcessDamage();

                // Try shield block
                if (attack.IsBlocked())
                {
                    actionTarget.reaction = REACTION_BLOCK;
                }

                actionTarget.param = battleutils::TakePhysicalDamage(this, PTarget, attack.GetAttackType(), attack.GetDamage(), attack.IsBlocked(), attack.GetWeaponSlot(), 1, attackRound.GetTAEntity(), true, true, attack.IsCountered(), attack.IsCovered(), POriginalTarget);
                if (actionTarget.param < 0)
                {
                    actionTarget.param = -(actionTarget.param);
                    actionTarget.messageID = 373;
                }
            }

            if (PTarget->objtype == TYPE_PC)
            {
                if (actionTarget.reaction == REACTION_GUARD || ((map_config.newstyle_skillups & NEWSTYLE_GUARD) > 0))
                {
                    if (battleutils::GetGuardRate(this, PTarget) > 0)
                    {
                        charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_GUARD, GetMLevel());
                    }
                }

                if (actionTarget.reaction == REACTION_BLOCK || ((map_config.newstyle_skillups & NEWSTYLE_BLOCK) > 0))
                {
                    if (battleutils::GetBlockRate(this, PTarget) > 0)
                    {
                        charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_SHIELD, GetMLevel());
                    }
                }

                if (actionTarget.reaction == REACTION_PARRY || ((map_config.newstyle_skillups & NEWSTYLE_PARRY) > 0))
                {
                    if (battleutils::GetParryRate(this, PTarget) > 0)
                    {
                        charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_PARRY, GetMLevel());
                    }
                }
                if (actionTarget.reaction != REACTION_EVADE && actionTarget.reaction != REACTION_PARRY)
                {
                    charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_EVASION, GetMLevel());
                }
            }
        }
        else
        {
            // misses the target
            actionTarget.reaction = REACTION_EVADE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.messageID = 15;
            attack.SetEvaded(true);

            // Check & Handle Afflatus Misery Accuracy Bonus
            battleutils::HandleAfflatusMiseryAccuracyBonus(this);

            if (PTarget->objtype == TYPE_PC) 
            {
                charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_EVASION, GetMLevel());
            }
            if (PTarget->objtype == TYPE_MOB && this->objtype == TYPE_PC)
            {
                // 1 ce for a missed attack for TH application
                ((CMobEntity*)PTarget)->PEnmityContainer->UpdateEnmity((CBattleEntity*)this, 1, 0);
            }
        }

        if (actionTarget.reaction != REACTION_HIT && actionTarget.reaction != REACTION_BLOCK && actionTarget.reaction != REACTION_GUARD)
        {
            actionTarget.param = 0;
        }

        if (actionTarget.reaction != REACTION_EVADE && actionTarget.reaction != REACTION_PARRY)
        {
            battleutils::HandleEnspell(this, PTarget, &actionTarget, attack.IsFirstSwing(), (CItemWeapon*)this->m_Weapons[attack.GetWeaponSlot()], attack.GetDamage());
            battleutils::HandleSpikesDamage(this, PTarget, &actionTarget, attack.GetDamage());
        }

        if (actionTarget.speceffect == SPECEFFECT_HIT && actionTarget.param > 0)
        {
            actionTarget.speceffect = SPECEFFECT_RECOIL;
        }

        //try zanshin only on single swing attack rounds - it is last priority in the multi-hit order
        //if zanshin procs, the attack is repeated
        if (attack.IsFirstSwing() && attackRound.GetAttackSwingCount() == 1)
        {
            uint16 zanshinChance = this->getMod(Mod::ZANSHIN) + battleutils::GetMeritValue(this, MERIT_ZANSHIN_ATTACK_RATE);
            zanshinChance = std::clamp<uint16>(zanshinChance, 0, 100);
            //zanshin may only proc on a missed/guarded/countered swing or as SAM main with hasso up (at 25% of the base zanshin rate)
            if ((actionTarget.reaction == REACTION_EVADE || actionTarget.reaction == REACTION_GUARD || actionTarget.spikesEffect == SUBEFFECT_COUNTER) && tpzrand::GetRandomNumber(100) < zanshinChance)
            {
                attack.SetAttackType(PHYSICAL_ATTACK_TYPE::ZANSHIN);
                attack.SetAsFirstSwing(false);
            }
            else
                attackRound.DeleteAttackSwing();
        }
        else
        {
            attackRound.DeleteAttackSwing();
        }
        if (list.actionTargets.size() == 8)
        {
            break;
        }
    }
    battleutils::ClaimMob(PTarget, this);
    PAI->EventHandler.triggerListener("ATTACK", this, PTarget, &action);
    PTarget->PAI->EventHandler.triggerListener("ATTACKED", PTarget, this, &action);
    PTarget->LastAttacked = server_clock::now();
    /////////////////////////////////////////////////////////////////////////////////////////////
    // End of attack loop
    /////////////////////////////////////////////////////////////////////////////////////////////

    this->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK | EFFECTFLAG_DETECTABLE);

    if (cover)
        PTarget->setModifier(Mod::COVERED_MP_FLAG, 0);

    return true;
}


CBattleEntity* CBattleEntity::IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg)
{
    auto PTarget = PAI->TargetFind->getValidTarget(targid, validTargetFlags);

    return PTarget;
}

void CBattleEntity::OnEngage(CAttackState& state)
{
    animation = ANIMATION_ATTACK;
    updatemask |= UPDATE_HP;
    PAI->EventHandler.triggerListener("ENGAGE", this, state.GetTarget());
}

void CBattleEntity::TryHitInterrupt(CBattleEntity* PAttacker)
{
    if (PAI->GetCurrentState())
        PAI->GetCurrentState()->TryInterrupt(PAttacker);
}

void CBattleEntity::OnDespawn()
{
    FadeOut();
    //#event despawn
    PAI->EventHandler.triggerListener("DESPAWN", this);
    PAI->Internal_Respawn(0s);
}

void CBattleEntity::SetBattleStartTime(time_point time)
{
    m_battleStartTime = time;
}

duration CBattleEntity::GetBattleTime()
{
    return server_clock::now() - m_battleStartTime;
}

void CBattleEntity::Tick(time_point)
{
}

void CBattleEntity::PostTick()
{
    if (health.hp == 0 && PAI->IsSpawned() && !PAI->IsCurrentState<CDeathState>() &&
        !PAI->IsCurrentState<CRaiseState>() && !PAI->IsCurrentState<CDespawnState>())
    {
        Die();
    }
}

uint16 CBattleEntity::GetBattleTargetID()
{
    return m_battleTarget;
}
