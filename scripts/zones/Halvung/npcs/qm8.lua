-----------------------------------
--  Area: Halvung
--  NPC: ??? (Bracelet of verve)
--  Trade Moblin Oil
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/items")

-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 8801) and not player:hasKeyItem(tpz.ki.BRACELET_OF_VERVE) then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, tpz.ki.BRACELET_OF_VERVE)
    else
        player:messageSpecial(ID.text.DULL_PIECE)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.DULL_PIECE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
