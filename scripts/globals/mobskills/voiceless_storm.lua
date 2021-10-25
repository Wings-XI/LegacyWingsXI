---------------------------------------------
--  Voiceless Storm
--  Description: A vacuum storm deals Wind damage to targets in an area of effect. Additional effect: Silence
--  Wipes Shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*4, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    return dmg
end
