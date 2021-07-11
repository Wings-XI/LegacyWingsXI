-----------------------------------------
-- ID: 5322
-- Item: Flask of Healing Powder
-- Item Effect: Restores 25% HP (AOE)
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local maxRecoverAmount = target:getMaxHP() * .25
    local missingHP = target:getMaxHP() - target:getHP()
    
    local recoveredAmount = maxRecoverAmount
    if recoveredAmount > missingHP then
        recoveredAmount = missingHP
    end
    
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, target:addHP(recoveredAmount))
    -- TODO - Find out how the effect and messaging should work
end
