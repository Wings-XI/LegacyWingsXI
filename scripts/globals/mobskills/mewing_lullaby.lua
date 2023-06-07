---------------------------------------------------
-- Mewing Lullaby
-- aoe light based sleep and lowers mob TP to zero
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
    local typeEffect = tpz.effect.LULLABY
    local duration = 60

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, duration))
    if skill:getMsg() == tpz.msg.basic.SKILL_ENFEEB_IS then
        target:setTP(0)
    end

    return typeEffect
end