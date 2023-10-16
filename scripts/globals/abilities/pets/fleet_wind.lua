---------------------------------------------
-- Aerial Armor
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/summon")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 114
    local typeEffect = tpz.effect.QUICKENING
    local duration = 90
    local bonus = math.floor(getSummoningSkillOverCap(pet) * duration / 30)
    duration = utils.clamp(duration + bonus, duration, 180)

    target:delStatusEffect(typeEffect)
    target:addStatusEffect(typeEffect, 25, 0, duration)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return typeEffect
end
