-----------------------------------------
-- ID: 5267
-- Item: Chunk Of Shu'Meyo Salt
-- Effect: Adds 20 seconds to the Snoll Tzar fight
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")
-----------------------------------------

local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")

function onItemCheck(target)
	local id = target:getID()
    
    -- only can use this item on snoll tzar
	if id ~= 16801793 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

function onItemUse(target, player)
    local salt = target:getLocalVar("salty")

    if (salt == 0) then -- random time until shaken off
        target:setLocalVar("delayed", os.time() + 20)
        target:setLocalVar("cooldown", os.time() + math.random(15, 20))
        target:setLocalVar("salty", 1)
        target:setLocalVar("melt", 1)    
        -- reset user's enmity
        target:resetEnmity(player)
    end
    -- else 
    -- no effect... retail doesnt have a message but item is still consumed
end
