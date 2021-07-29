-----------------------------------------
-- ID: 5262 
-- Item: Bottle Of Hysteroanima
-- Item Effect: Amnesia
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")

function onItemCheck(target)
    local result = 0
    
	if target:getSystem() ~= 12 then -- empty
        result tpz.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = tpz.msg.basic.TOO_FAR_AWAY

    return result
end

function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.AMNESIA)
	target:addStatusEffect(tpz.effect.AMNESIA, 1, 0, math.random(25,32))
	target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.AMNESIA)
end
