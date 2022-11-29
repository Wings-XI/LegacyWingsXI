---------------------------------------------
--  Sea Spray
--  tsusemi/Blink absorb: Ignores shadows
--  Description: Deals water damage that inflicts slow in a cone
--  Type: Magical (Water/Breath)
--  Range:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local cap = 500
    local dmgmod = MobBreathMove(mob, target, 0.15, 3, tpz.magic.ele.WATER, cap)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)

    MobStatusEffectMove(mob, target, tpz.effect.SLOW, 2000, 0, 60)

    return dmg
end