-----------------------------------
-- Area: Qufim_Island
--  NPC: Hieroglyphics
-- Dynamis Qufim Entrance
-- !pos 16 -19 162 126
-----------------------------------
require("scripts/globals/dynamis")
local ID = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    dynamis.entryNpcOnTrade(player, npc, trade, ID.text.PLAYERS_HAVE_NOT_REACHED_LEVEL, ID.text.ANOTHER_GROUP, ID.text.YOU_CANNOT_ENTER_DYNAMIS)
end

function onTrigger(player, npc)
    dynamis.entryNpcOnTrigger(player, npc, ID.text.DYNA_NPC_DEFAULT_MESSAGE)
end

function onEventUpdate(player, csid, option)
    dynamis.entryNpcOnEventUpdate(player, csid, option, ID.text.UNABLE_TO_CONNECT)
end

function onEventFinish(player, csid, option)
    dynamis.entryNpcOnEventFinish(player, csid, option, ID.text.CONNECTING_WITH_THE_SERVER, ID.text.UNABLE_TO_CONNECT)
end

function onDynamisServerReply(player, result)
    dynamis.entryNpcOnDynamisServerReply(player, result, ID.text.INFORMATION_RECORDED, ID.text.ITEM_OBTAINED)
end
