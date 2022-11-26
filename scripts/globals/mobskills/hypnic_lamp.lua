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
    if mob:getID() == 16998874 then
        if mob:getLocalVar("Phase") == 1 and math.random(1,100) > 95 then
            return 0
        else
            return 1
        end
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I
    local duration = 60

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    if mob:getID() == 16998874 then
        mob:setLocalVar("Phase", 2)
        mob:setLocalVar("Changed",1)
    end

    return typeEffect
end
