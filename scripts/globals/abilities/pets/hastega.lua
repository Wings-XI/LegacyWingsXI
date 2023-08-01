---------------------------------------------
-- Hastega
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
    local mpCost = 129
    local duration = 90
    local bonus = math.floor(getSummoningSkillOverCap(pet) * duration / 30)
    duration = utils.clamp(duration + bonus, duration, 180)

    local power = 1494 -- 153/1024 ~14.94%

    -- Garuda's Hastega is a weird exception and uses 153/1024 instead of 150/1024 like Haste spell
    -- That's why it overwrites some things regular haste won't.
    -- WINGSCUSTOM: Special modification to allow regular haste not to be overwritten by hastega
    -- if the time left is greater than duration supplied by hastega.
    local currentHaste = target:getStatusEffect(tpz.effect.HASTE)
    if currentHaste then
        if
            (currentHaste:getPower() > 1450 and
            currentHaste:getTimeRemaining()/1000 > duration)
        then
            skill:setMsg(tpz.msg.basic.NO_EFFECT)
            return tpz.effect.HASTE
        end
    end

    target:addStatusEffect(tpz.effect.HASTE, power, 0, duration)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return tpz.effect.HASTE
end
