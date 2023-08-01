---------------------------------------------
-- Crimson Howl
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
require("scripts/globals/summon")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local mpCost = 84
    local duration = 30
    local bonus = math.floor(getSummoningSkillOverCap(pet) * duration / 30)
    duration = utils.clamp(duration + bonus, duration, 180)

    target:addStatusEffect(tpz.effect.WARCRY, 9, 0, duration)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return tpz.effect.WARCRY
end
