---------------------------------------------
-- Washtub
-- Riko Kupenriech - AMK14 Smash! A Malevolent Menace
-- Drops a washtub on foes within area of effect. Additonal Effect: Amnesia and Stun
-- Utsusemi/Blink absorb: 3 shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 3
    local dmgmod = 0.6
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOBPARAM_3_SHADOW)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    if dmg > 0 and skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB then
        MobStatusEffectMove(mob, target, tpz.effect.STUN, 1, 0, math.random(5, 8))
        MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, math.random(20, 40))
        MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, math.random(60, 90))
    end

    return dmg
end
