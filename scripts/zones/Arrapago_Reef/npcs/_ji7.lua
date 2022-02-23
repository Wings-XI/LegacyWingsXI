-----------------------------------
-- Area: Arrapago Reef
-- Door: Tidal Gate (Red: Lamian Fang Key, Lamian Bone Key, Lamian Claw Key)
-- !pos -402 -16 420 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, {2218, 2219, 2220}) then
        npc:openDoor(10)
        player:confirmTrade() 
    end
end

function onTrigger(player, npc)
    
end

function onEventUpdate(player, csid, option, target)
    
end

function onEventFinish(player, csid, option, target)

end

function onInstanceCreated(player, target, instance)
    
end