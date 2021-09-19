-----------------------------------
-- Area: Port Windurst
--   NPC: Paytah
-- Type: Standard NPC
-- !pos 77.550 -6 117.769 240
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(288)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
