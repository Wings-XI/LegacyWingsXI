---------------------------------------------
-- Putrid Breath
-- Description: Deals breath damage to enemies around the target.
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

    local cap = mob:getLocalVar("putridbreathcap")
    
    local dmgmod = MobBreathMove(mob, target, 0.15, 3, tpz.magic.ele.EARTH, cap)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.EARTH)
    return dmg
end