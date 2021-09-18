-----------------------------------
-- Area: Bastok Mines
--   NPC: Gonija
-- Type: Chocobo Breeder
-- !pos 28 0 -105 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(534)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
