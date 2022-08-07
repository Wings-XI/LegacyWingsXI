-----------------------------------
--  Frozen Mist
--
--  Description: Releases a very cold mist that deals light damage and terror.
--  Type: Magical (Ice)
--  Utsusemi/Blink absorb: ignores
--  Range: Area of Effect (10 yalms)
--  Notes: ffxiclopedia.fandom.com claims that this move can randomly remove 1 to 3 pieces of equipment,
--         but I could not find any evidences it did after multiple fights against these mobs.
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() / 2, tpz.magic.ele.ICE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    MobStatusEffectMove(mob, target, tpz.effect.TERROR, 1, 0, 20)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end