-----------------------------------------
-- ID: 5330
-- Item: Mithra Snare
-- Item Effect: Prevents 2hr use
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")

function onItemCheck(target, param, player)
    local result = 0
    local mobids = { 17199602, 17199604, 17199603 }

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
	target:addStatusEffect(tpz.effect.MEDICINE, 1, 0, 300)
end

function onEffectGain(target, effect)
end

function onEffectLose(target, effect)
end