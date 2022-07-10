-----------------------------------
-- Area: Jugner_Forest [S]
--  NPC: ???
-- !pos 10.949 -12.481 -510.149
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2565) and npcUtil.popFromQM(player, npc, ID.mob.VULKODLAC) then -- Gnole Pellets
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
