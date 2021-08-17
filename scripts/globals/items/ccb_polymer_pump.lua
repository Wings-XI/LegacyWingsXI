-----------------------------------------
-- ID: 5268
-- Item: CCB polymer Pump
-- Item Effect: Amnesia
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")

function onItemCheck(target, param, player)
    local result = 0
    local mobids = { 16908295, 16908302, 1690830, 16908294, 16908301, 16908308 }

    if target:checkDistance(player) > 10 then               
        return tpz.msg.basic.TOO_FAR_AWAY 
    end

    for i in pairs(mobids) do
        if target:getID() == mobids[i] then
            result = 1
        end
    end    

    if result == 1 then
        return 0
    else    
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
end




function onItemUse(target)
    target:delStatusEffectSilent(tpz.effect.AMNESIA)
	target:addStatusEffect(tpz.effect.AMNESIA, 1, 0, 60)
	target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.AMNESIA)
end