-----------------------------------
-- Area: Windurst Walls
--  NPC: Komomo
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(290)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
