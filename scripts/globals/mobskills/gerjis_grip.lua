---------------------------------------------
-- Gerjis' Grip
-- Description: Stun
-- Type: Physical (Blunt)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STUN
    local duration = 10

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end
