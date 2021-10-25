-----------------------------------
-- Area: Newton_Movalpolos
--  NPC: ??? for Goblin Collector
-----------------------------------
local ID = require("scripts/zones/Newton_Movalpolos/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1827) and npcUtil.popFromQM(player, npc, ID.mob.GOBLIN_COLLECTOR) then
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
