---------------------------------------------------
-- Ability: Feral Howl
-- Terrorizes the target.
-- Obtained: Beastmaster Level 75
-- Recast Time: 0:05:00
-- Duration: Apprx. 0:00:01 - 0:00:10
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local dCHR = player:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR)
    local chance = 75 + player:getMerit(tpz.merit.FERAL_HOWL) + player:getMainLvl() - target:getMainLvl() + dCHR
    local minDuration = math.floor(dCHR/4)
    if minDuration < 1 then
        minDuration = 1
    elseif minDuration > 5 then
        minDuration = 5
    end

    if target:hasImmunity(16384) then
        ability:setMsg(tpz.msg.basic.TP_NO_EFFECT)
        return tpz.effect.TERROR
    end

    --print(string.format("feral howl chance = %u",chance))
    if not target:hasStatusEffect(tpz.effect.TERROR) and not target:hasStatusEffect(tpz.effect.STUN) and math.random() < chance/100 then
        target:addStatusEffect(tpz.effect.TERROR,1,0,math.random(minDuration,10))
    else
        ability:setMsg(tpz.msg.basic.JA_MISS_2)
        return target:getID()
    end
    ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)
    return tpz.effect.TERROR
end
