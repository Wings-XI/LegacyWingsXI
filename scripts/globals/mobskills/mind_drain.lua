---------------------------------------------
-- Mind Drain
-- Steals mnd from target
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.MND_DOWN

    skill:setMsg(MobDrainAttribute(mob, target, typeEffect, 10, 3, 60))

    return typeEffect
end
