-----------------------------------
--  Aqua Cannon
--
--  Description: Fires a powerful blast of Water, dealing damage in a fan-shaped area. Additional effect: knockback.
--  Type: Magical (Water)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Front conal (16 yalms)
--  Notes: Scylla exclusive, this skill is not used on its own and will always come after Aqua Wave.
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end