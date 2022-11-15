---------------------------------------------
-- Hypnic Lamp
-- Description: Sleeps opponents with a gaze attack.
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: conal gaze
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I
    local duration = 60

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end
