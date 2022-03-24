-----------------------------------
-- Area: Lufaise Meadows
--  NPC: ??? - Kurrea spawn
-- !pos -249.320 -16.189 41.497 24
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 5210) and npcUtil.popFromQM(player, npc, ID.mob.KURREA) then -- Adamantoise Soup
        player:confirmTrade()
        player:messageSpecial(ID.text.KURREA_SPAWN_TEXT, 5210)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.KURREA_QM_TEXT)
end
