-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Arvilauge
-- Optional Involvement in Quest: A Squire's Test II
-- !pos -11 1 -94 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/starlight_festivals")
-------------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(846)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
