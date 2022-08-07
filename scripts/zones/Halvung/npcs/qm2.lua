-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Dextrose(ZNM T2))
-- !pos -144 11 464 62
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2589) and npcUtil.popFromQM(player, npc, ID.mob.DEXTROSE) then -- Granulated Sugar
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.DEXTROSE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
