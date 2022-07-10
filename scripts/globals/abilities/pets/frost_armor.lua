---------------------------------------------
-- Frost Armor
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
    local mpCost = 63
    local bonus = getSummoningSkillOverCap(pet) * 3
    if bonus > 90 then
        bonus = 90
    end

    target:delStatusEffect(tpz.effect.ICE_SPIKES)
    target:addStatusEffect(tpz.effect.ICE_SPIKES, 15, 0, 90+bonus)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return tpz.effect.ICE_SPIKES
end
