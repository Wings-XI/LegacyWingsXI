---------------------------------------------
-- Washtub
-- Riko Kupenriech - AMK14 Smash! A Malevolent Menace
-- Drops a washtub on foes within area of effect. Additonal Effect: Amnesia and Stun
-- Utsusemi/Blink absorb: 3 shadows
---------------------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    skill:setAnim(1504)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 3
    local dmgmod = 1.9
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, MOB_PARAM_3_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    if info.hitslanded > 0 then
        MobStatusEffectMove(mob, target, tpz.effect.STUN, 1, 0, 10)
        MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 30)
        MobStatusEffectMove(mob, target, tpz.effect.AMNESIA, 1, 0, 120)
    end

    mob:showText(mob, ID.text.BOOBY_PRIZE)

    return dmg
end
