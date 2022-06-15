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
    local bonus = getSummoningSkillOverCap(pet)
    if bonus > 90 then
        bonus = 90
    end

    target:addStatusEffect(tpz.effect.WARCRY, 9, 0,30+bonus)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    pet:getMaster():addMP(-mpCost)
    return tpz.effect.WARCRY
end
