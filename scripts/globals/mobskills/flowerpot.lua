---------------------------------------------
-- Flowerpot
-- Henchman Moogle - AMK14 Smash! A Malevolent Menace
-- Utsusemi: 1 Shadow
-- Drops a flowerpot on an enemy, disorientating them. Additional Effect: Blind, Stun, and Amnesia
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOBPARAM_1_SHADOW)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    if dmg > 0 and skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB then
        MobStatusEffectMove(mob, target, tpz.effect.STUN, 1, 0, 6)
        MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 1, 0, 120)
        MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, math.random(45, 60))
    end

    return dmg
end
