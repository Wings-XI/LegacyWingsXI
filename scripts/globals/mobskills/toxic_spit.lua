---------------------------------------------
--  Toxic Spit
--
--  Description: Spews a toxic glob at a single target. Effect: Poison
--  Type: Magical Water
--  Utsusemi/Blink absorb: Ignores shadows
--  Notes: Additional effect can be removed with Poisona.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.POISON
    local power = mob:getMainLvl()/5 + 3
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 180)
end
