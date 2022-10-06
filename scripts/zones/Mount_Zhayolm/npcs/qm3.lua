-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Anantaboga(ZNM T2))
-- !pos -368 -13 366 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2587) and npcUtil.popFromQM(player, npc, ID.mob.ANANTABOGA, {hide = 0}) then -- Raw Buffalo
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.ANANTABOGA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
