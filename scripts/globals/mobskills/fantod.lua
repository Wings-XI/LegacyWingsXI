---------------------------------------------
-- Fantod
-- Hippogryph Boost Ability.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, 12.5, 0, 180))
    return typeEffect
end