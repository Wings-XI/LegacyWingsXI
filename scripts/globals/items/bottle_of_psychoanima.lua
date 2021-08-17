-----------------------------------------
-- ID: 5261 
-- Item: Bottle Of Psychoanima
-- Item Effect: Intimidate 
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")
-----------------------------------------

function onItemCheck(target, param, player)
    local result = 0
    
	if target:getSystem() ~= 12 then -- empty
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = tpz.msg.basic.TOO_FAR_AWAY
    end

    return result
end

function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.INTIMIDATE)
	target:addStatusEffect(tpz.effect.INTIMIDATE, 1, 0, math.random(25,32))
	target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.INTIMIDATE)
end
