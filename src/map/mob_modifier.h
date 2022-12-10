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
#ifndef _CMOBMODIFIER_H
#define _CMOBMODIFIER_H

/*
This is a list of mob specific modifiers. They can be added to pools / families / spawn points.
Gets mapped for convenience in scripts/globals/status.lua#2223+ -- always edit both
*/

enum MOBMODIFIER : int
{
    MOBMOD_NONE                = 0,
    MOBMOD_GIL_MIN             = 1,  // minimum gil drop -- spawn mod only
    MOBMOD_GIL_MAX             = 2,  // maximum gil drop -- spawn mod only
    MOBMOD_MP_BASE             = 3,  // Give mob mp. Used for mobs that are not mages, wyverns, avatars
    MOBMOD_SIGHT_RANGE         = 4,  // sight range
    MOBMOD_SOUND_RANGE         = 5,  // sound range
    MOBMOD_BUFF_CHANCE         = 6,  // % chance to buff (combat only)
    MOBMOD_GA_CHANCE           = 7,  // % chance to use -ga spell
    MOBMOD_HEAL_CHANCE         = 8,  // % chance to use heal
    MOBMOD_HP_HEAL_CHANCE      = 9,  // can cast cures below this HP %
    MOBMOD_SUBLINK             = 10, // sub link group
    MOBMOD_LINK_RADIUS         = 11, // link radius
    MOBMOD_DRAW_IN             = 12, // mob will draw-in if its target wanders too far away. can set additional parameters with mobmods 76/77/78/79
    MOBMOD_DRAW_IN_CUSTOM_RANGE= 76, // override the default range of MeleeRange*2 of when players start to get drawn-in
    MOBMOD_DRAW_IN_MAXIMUM_REACH=77, // players further than this range (yalms) will be unaffected by the draw-in. default (0) is whole zone
    MOBMOD_DRAW_IN_INCLUDE_PARTY=78, // this will cause the mob's draw-in to also affect all party and alliance members
    MOBMOD_DRAW_IN_IGNORE_STATIONARY=79, // stationary mobs draw-in the moment they cannot attack you anymore (out of range). put this mobmod on stationary mobs that have draw-in but use ranged attacks instead of melee attacks so that they will ignore this behavior (i.e. KSNM99 Wyrm or Nyzul Isle Alexander)
    MOBMOD_DRAW_IN_FRONT       = 80, // certain mobs draw in slightly in front them instead of the middle of their hit box. put in this mobmod to not draw in to the center of the mob.
    MOBMOD_SEVERE_SPELL_CHANCE = 13, // % chance to use a severe spell like death or impact
    MOBMOD_SKILL_LIST          = 14, // uses given mob skill list
    MOBMOD_MUG_GIL             = 15, // amount gil carried for mugging
    MOBMOD_DAMAGE_ENMITY_PERC  = 16, // percent modifier of how much enmity damaging attacks/skills/spells will generate, default 100%, default for NMs 110%
    MOBMOD_NO_DESPAWN          = 17, // do not despawn when too far from spawn. Gob Diggers have this.
    MOBMOD_VAR                 = 18, // temp var for whatever. Gets cleared on spawn
    // 19 Available for use
    MOBMOD_TP_USE_CHANCE       = 20, // % chance to use tp
    MOBMOD_PET_SPELL_LIST      = 21, // set pet spell list
    MOBMOD_NA_CHANCE           = 22, // % chance to cast -na
    MOBMOD_IMMUNITY            = 23, // immune to set status effects. This only works from the db, not scripts
    MOBMOD_GRADUAL_RAGE        = 24, // (!) TODO: NOT YET IMPLEMENTED -- gradually rages
    MOBMOD_BUILD_RESIST        = 25, // (!) TODO: NOT YET IMPLEMENTED -- builds resistance to given effects
    MOBMOD_SUPERLINK           = 26, // super link group. Only use this in mob_spawn_mods / scripts!
    MOBMOD_SPELL_LIST          = 27, // set spell list
    MOBMOD_EXP_BONUS           = 28, // bonus exp (bonus / 100) negative values reduce exp.
    MOBMOD_ASSIST              = 29, // mobs will assist me
    MOBMOD_SPECIAL_SKILL       = 30, // give special skill
    MOBMOD_ROAM_DISTANCE       = 31, // distance allowed to roam from spawn
    // 32 Available for use
    MOBMOD_SPECIAL_COOL        = 33, // cool down for special
    MOBMOD_MAGIC_COOL          = 34, // cool down for magic
    MOBMOD_STANDBACK_COOL      = 35, // cool down time for standing back (casting spell while not in attack range)
    MOBMOD_ROAM_COOL           = 36, // cool down time in seconds after roaming
    MOBMOD_ALWAYS_AGGRO        = 37, // aggro regardless of level. Spheroids
    MOBMOD_NO_DROPS            = 38, // If set monster cannot drop any items, not even seals.
    MOBMOD_SHARE_POS           = 39, // share a pos with another mob (eald'narche exoplates)
    MOBMOD_TELEPORT_CD         = 40, // cooldown for teleport abilities (tarutaru AA, angra mainyu, eald'narche)
    MOBMOD_TELEPORT_START      = 41, // mobskill ID to begin teleport
    MOBMOD_TELEPORT_END        = 42, // mobskill ID to end teleport
    MOBMOD_TELEPORT_TYPE       = 43, // teleport type - 1: on cooldown, 2 - to close distance
    MOBMOD_DUAL_WIELD          = 44, // enables a mob to use their offhand in attacks
    MOBMOD_ADD_EFFECT          = 45, // enables additional effect script to process on mobs attacks
    MOBMOD_AUTO_SPIKES         = 46, // enables additional effect script to process when mob is attacked
    MOBMOD_SPAWN_LEASH         = 47, // forces a mob to not move farther from its spawn than its leash distance
    MOBMOD_SHARE_TARGET        = 48, // mob always targets same target as ID in this var
    MOBMOD_CHECK_AS_NM         = 49, // If set , mob will check as a NM
    // 50 Available for use
    MOBMOD_ROAM_TURNS          = 51, // Maximum amount of turns during a roam
    MOBMOD_ROAM_RATE           = 52, // Roaming frequency. roam_cool - rand(roam_cool / (roam_rate / 10))
    MOBMOD_BEHAVIOR            = 53, // Add behaviors to mob
    MOBMOD_GIL_BONUS           = 54, // Allow mob to drop gil. Multiplier to gil dropped by mob (bonus / 100) * total
    MOBMOD_IDLE_DESPAWN        = 55, // Time (in seconds) to despawn after being idle
    MOBMOD_HP_STANDBACK        = 56, // mob will always standback with hp % higher to value
    MOBMOD_MAGIC_DELAY         = 57, // Amount of seconds mob waits before casting first spell
    MOBMOD_SPECIAL_DELAY       = 58, // Amount of seconds mob waits before using first special
    MOBMOD_WEAPON_BONUS        = 59, // Add a bonus percentage to mob weapon damage ( bonus / 100 )
    MOBMOD_SPAWN_ANIMATIONSUB  = 60, // reset animationsub to this on spawn
    MOBMOD_HP_SCALE            = 61, // Scale the mobs max HP. ( hp_scale / 100 ) * maxhp
    MOBMOD_NO_STANDBACK        = 62, // Mob will never standback
    MOBMOD_ATTACK_SKILL_LIST   = 63, // skill list to use in place of regular attacks
    MOBMOD_CHARMABLE           = 64, // mob is charmable
    MOBMOD_NO_MOVE             = 65, // Mob will not be able to move
    MOBMOD_MULTI_HIT           = 66, // Mob will have as many swings as defined.
    MOBMOD_NO_AGGRO            = 67, // If set, mob cannot aggro until unset.
    MOBMOD_ALLI_HATE           = 68, // Range around target to add alliance member to enmity list.
    MOBMOD_NO_LINK             = 69, // If set, mob cannot link until unset.
    MOBMOD_NO_REST             = 70, // Mob cannot regain hp (e.g. re-burrowing antlions during ENM).
    MOBMOD_BCNM_LINK           = 71, // all BCNM mobs sound link each other
    MOBMOD_CLAIM_SHIELD        = 72, // lottery pick to everyone who performed an action
    MOBMOD_ATTRACT_FAMILY_NM   = 73, // NMs within the same family will link onto this mob (used on Sabotenders for Cactrot Rapido)
    MOBMOD_FAMILYLINK          = 74, // Mob will link with mobs of the same familly in the zone. Usefull to make a NM link if the family doesn't, like Cactrot Rapido.
    MOBMOD_ENCROACH_PLAYER     = 75,
    // #76 and #77 and #78 and #79 and #80 are taken (placed next to #12 for clarity)
    MOBMOD_SIGHT_ANGLE         = 84, // Angle in which a mob will detect by sight
    MOBMOD_FOMOR_HATE          = 85, // Mob aggros according to fomor hate
    MOBMOD_PIXIE               = 86, // Pixie (heals players)
    MOBMOD_PLAYER_ABILITY      = 87, // Reacts to player abilities (currently only Tethra uses this)
};

#endif
