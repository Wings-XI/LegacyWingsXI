---------------------------------------------
--  Storm Wing
--  Family: Amphiptere
--  Description: Deals damage to enemies within a fan-shaped area. 
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores?
--  Range: 20' Cone
--  Notes: Additional effect: Silence
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SILENCE

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 60)

    local dmgmod = 3
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    return dmg
end
