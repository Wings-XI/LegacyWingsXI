---------------------------------------------
--  Stupor Spores
--  Description: Spreads intoxicating spores that damages nearby targets. Additional effect: Sleep
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores Shadows
--  Range: Unknown radial
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg(), tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)

    local typeEffect = tpz.effect.SLEEP_I
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    return dmg
end
