---------------------------------------------
-- Bill Toss
-- Description: Shocks foes with ridiculous weath. Additional effect: Terror
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown Cone
-- Notes: Only used by Riko Kupenreich. It's possible to turn around or get out of the way while he readies it.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local duration = 30

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end
