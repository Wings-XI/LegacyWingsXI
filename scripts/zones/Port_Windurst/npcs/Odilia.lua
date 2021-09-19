-----------------------------------
-- Area: Port Windurst
--   NPC: Odilia
-- Type: Standard NPC
-- !pos 78.801 -6 118.653 240
--
-- Auto-Script: Requires Verification (Verfied By Brawndo)
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(289)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
