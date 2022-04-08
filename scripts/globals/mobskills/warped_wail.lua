---------------------------------------------
-- Warped Wail
--
-- Description: Lowers maximum HP/MP of targets in an area of effect.
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' radial
-- Notes: 12% reduction - Best guess based on captures
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.MAX_HP_DOWN
    local typeEffect2 = tpz.effect.MAX_MP_DOWN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 12, 0, 300)) -- 12% HP reduction 5min duration
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect2, 12, 0, 300)) -- 12% MP reduction 5min duration

    return typeEffect
end
