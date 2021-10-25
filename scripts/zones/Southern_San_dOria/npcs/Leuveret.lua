-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Leuveret
-- Type: General Info NPC
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/events/starlight_festivals")
-------------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
    quests.ffr.onTrade(player, npc, trade, 14) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    player:startEvent(621)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
