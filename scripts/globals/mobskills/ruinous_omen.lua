---------------------------------------------------
-- Ruinous Omen
-- Used by:  Diabolos
-- Deals damage equal to a random percentage of HP to enemies within area of effect
-- https://ffxiclopedia.fandom.com/wiki/Ruinous_Omen
-- Prime Avatar seems to do an unresisted ~66% HP reduction from players' current HP (not max HP)
-- RO by design cannot KO a target, but can significantly reduce its HP
-- Version used by player summoners seems capped at ~2% except against Behemoths
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/summon")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    mob:messageBasic(tpz.msg.basic.READIES_WS, 0, skill:getID())
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dINT = math.floor(mob:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))

    -- Target HPP decrease seems to be about 66% unresisted.
    -- Maximum observed 72% (weakness to darkness?)
    -- Minimum observed 44% (high resist)
    local hppTarget = 66
    local hppMin = 44
    local hppMax = 75
    local dmgmod = 0.7   -- Estimated from keeping with a max of ~72% reduction
    local ratio = 4
    if dINT >= 0 then ratio = 6 end  -- Tilt the curve so that a small dINT doesn't tip too far in Diabolos' favour.
    hppTarget = hppTarget + (dINT / 6)    -- A wild estimate.  Diabolos INT is 131 in Waking Dreams.

    -- hpp and damage do not correlate, but we can use the system to scale damage numbers
    hppTarget = MobMagicalMove(mob, target, skill, hppTarget, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT, 0)
    hppTarget = mobAddBonuses(mob, nil, target, hppTarget.dmg, tpz.magic.ele.DARK)
    hppTarget = AvatarFinalAdjustments(hppTarget, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    -- Clamp the HPP reduction to a 75% total cap and a 40% total Minimum
    hppTarget = utils.clamp(hppTarget, hppMin, hppMax)

    -- Convert the reduction into a player-specific amount based on their current HP
    local damage = target:getHP() * hppTarget / 100

    target:takeDamage(damage, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    return damage
end