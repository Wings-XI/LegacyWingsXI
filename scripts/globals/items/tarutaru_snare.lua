-----------------------------------------
-- ID: 5329
-- Item: Tarutaru Snare
-- Item Effect: Mob hits for only 1 or 2(crit) damage for 60 seconds
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 60, 5329)
end

function onEffectGain(target, effect)
end

function onEffectLose(target, effect)
end