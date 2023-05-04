---------------------------------------------
--  Predatory Glare
--
--  Description: Glares at targets in a fan-shaped area of effect. Additional effect: Stun
--  Type: Gaze
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Forward Conal
--  Notes: Only used by nightmare Tigers in Dynamis-Qufim and Saehrimnir in Einherjar
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STUN
    local duration = math.random(5, 12)

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end
