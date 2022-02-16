---------------------------------------------
-- Miasmic Breath
-- Description: A toxic odor is exhaled on any players in a fan-shaped area of effect.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: 15' Conal
-- Notes: Only used by Cirrate Christelle
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.POISON
    local power = mob:getLocalVar("miasmicbreathpower")

    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = MobBreathMove(mob, target, 0.1, 1.25, tpz.magic.ele.WATER, 200)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    return dmg
end