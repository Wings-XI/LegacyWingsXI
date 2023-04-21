---------------------------------------------
--  Frost Breath
--
--  Description: Deals ice damage to enemies within a fan-shaped area originating from the caster. Additional effect: Paralysis.
--  Type: Magical (Ice)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- only used in Uleguerand_Range and Dynamis-Qufim
    if (mob:getZoneID() == 5 or mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS
    local power = 25
    if (mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        power = 75
    end

    MobStatusEffectMove(mob, target, typeEffect, power, 0, 120)

    local dmgmod = MobBreathMove(mob, target, 0.333, 0.625, tpz.magic.ele.ICE, 500)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.ICE)
    return dmg
end
