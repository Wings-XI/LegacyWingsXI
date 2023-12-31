---------------------------------------------
-- Mog Shrapnel
-- Henchman Moogle - AMK14 Smash! A Malevolent Menace
-- Utsusemi: 2 Shadow
-- Tosses gil at foes within a fan-shaped area.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 2
    local accmod = .8
    local dmgmod = .8
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_2_SHADOW)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
