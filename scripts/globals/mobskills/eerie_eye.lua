---------------------------------------------------
-- Eerie Eye
-- silence + amnesia
---------------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/magic")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.NONE
    local returnEffect = tpz.effect.NONE
    local msg = tpz.msg.basic.NO_EFFECT
    local duration = 15

    typeEffect = tpz.effect.SILENCE
    msg = MobGazeMove(mob, target, typeEffect, 1, 0, duration)
    if msg == tpz.msg.basic.SKILL_ENFEEB_IS then returnEffect = typeEffect end

    typeEffect = tpz.effect.AMNESIA
    msg = MobGazeMove(mob, target, typeEffect, 1, 0, duration)
    if msg == tpz.msg.basic.SKILL_ENFEEB_IS then returnEffect = typeEffect end

    if returnEffect ~= tpz.effect.NONE then
        msg = tpz.msg.basic.SKILL_ENFEEB_IS
    else
        msg = tpz.msg.basic.NO_EFFECT
    end
    skill:setMsg(msg)
    return returnEffect
end
