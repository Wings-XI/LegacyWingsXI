-----------------------------------------
-- ID: 
-- Item: 
-- Item Effect: 
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")

function onItemCheck(target)
	if target:getSystem() ~= 12 then -- empty
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.AMNESIA)
	target:addStatusEffect(tpz.effect.AMNESIA, 1, 0, math.random(25,32))
	target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.AMNESIA)
end
