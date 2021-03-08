---------------------------------------------
--  Sweet Breath
--
--  Description: Deals water damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical Water (Element)
--
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
    if mob:getID() == 17613130 then -- Cap. Cassie
        cap = 250
    end
    
    local dmgmod = MobBreathMove(mob, target, 0.125, 3, tpz.magic.ele.WATER, cap)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    
    local typeEffect = tpz.effect.SLEEP_I
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)
    
    return dmg
end
