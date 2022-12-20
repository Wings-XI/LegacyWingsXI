-----------------------------------
-- Sheep Charge Melee
-- Deals damage to a single target. Additional effect: Knockback
-- Used in BCNM: Hostile Herbivores as an additional affect on melee swings
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmg = 0
    return dmg
end
