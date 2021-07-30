---------------------------------------------
-- Chthonian Ray
-- Only used by Mindertaur
-- Description: Inflicts Doom to enemies with a gaze attack.  The doom effect from this move cannot be removed.
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/settings")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DOOM
    -- Setting the Power to be greater than the default 10 to make this effect not-removeable
    skill:setMsg(MobGazeMove(mob, target, typeEffect, 11, 3, 30))

    return typeEffect
end
