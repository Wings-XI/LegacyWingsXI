-----------------------------------
-- Area: Attohwa Chasm
--  NPC: ???
-- !pos -402.574 3.999 -202.750 7
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1825) and npcUtil.popFromQM(player, npc, ID.mob.FEELER_ANTLION) then
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.OCCASIONAL_LUMPS)
end
