---------------------------------------------
-- Glittering Ruby
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
    local mpCost = 62
    --randomly give str/dex/vit/agi/int/mnd/chr (+12)
    local effect = math.random()
    local effectid = tpz.effect.STR_BOOST
    if (effect<=0.14) then --STR
        effectid = tpz.effect.STR_BOOST
    elseif (effect<=0.28) then --DEX
        effectid = tpz.effect.DEX_BOOST
    elseif (effect<=0.42) then --VIT
        effectid = tpz.effect.VIT_BOOST
    elseif (effect<=0.56) then --AGI
        effectid = tpz.effect.AGI_BOOST
    elseif (effect<=0.7) then --INT
        effectid = tpz.effect.INT_BOOST
    elseif (effect<=0.84) then --MND
        effectid = tpz.effect.MND_BOOST
    else --CHR
        effectid = tpz.effect.CHR_BOOST
    end
    local duration = 90
    local bonus = math.floor(getSummoningSkillOverCap(pet) * duration / 30)
    duration = utils.clamp(duration + bonus, duration, 180)

    target:addStatusEffect(effectid, math.random(12, 14), 0, duration)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return effectid
end
