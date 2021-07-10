-----------------------------------------
-- ID: 4255
-- Item: Pinch of Mana Powder
-- Item Effect: Restores 25% MP (AOE)
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local maxRecoverAmount = target:getMaxMP() * .25
    local missingMP = target:getMaxMP() - target:getMP()
    
    local recoveredAmount = maxRecoverAmount
    if recoveredAmount > missingMP then
        recoveredAmount = missingMP
    end
    
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, target:addMP(recoveredAmount))
    -- TODO - Find out how the effect and messaging should work
end
