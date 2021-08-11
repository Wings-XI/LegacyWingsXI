---------------------------------------------
--  Pet Lightning Breath
--  Description: Deals lightning breath damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Lightning)
--  Notes: Used by Monster Wyvern Pets
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = MobBreathMove(mob, target, 0.15, 0.25, tpz.magic.ele.THUNDER, 125)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.LIGHTNING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.LIGHTNING)
    return dmg
end
