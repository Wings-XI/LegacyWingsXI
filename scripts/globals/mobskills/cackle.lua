---------------------------------------------------
--  Cackle
--  Reduces magical attack, magical accuracy, or magical defense of targets in an area of effect.
-- Video evidence that it's only ever one effect applied to all targets in AoE: https://youtu.be/T_Us2Tmlm-E?t=206
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------------

local typeEffects = {
    tpz.effect.MAGIC_ATK_DOWN,
    tpz.effect.MAGIC_ACC_DOWN,
    tpz.effect.MAGIC_DEF_DOWN,
}

function onMobSkillCheck(target, mob, skill)
    -- smaller range to use, but 30 yalm AoE. Effectively cannot out-range the skill
    if mob:checkDistance(target) > 10 then
        return 1
    end
    mob:setLocalVar("cackle-index", math.random(1,#typeEffects))
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local power = 40
    local duration = 60
    local returnEffect = tpz.effect.NONE
    local typeEffect = typeEffects[mob:getLocalVar("cackle-index")]

    skill:setMsg(tpz.msg.basic.SKILL_MISS)
    if MobStatusEffectMove(mob, target, typeEffect, power, 0, duration) == tpz.msg.basic.SKILL_ENFEEB_IS then
        returnEffect = typeEffect
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
    end
    return returnEffect
end
