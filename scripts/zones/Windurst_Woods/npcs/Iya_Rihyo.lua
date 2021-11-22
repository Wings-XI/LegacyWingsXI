-----------------------------------
-- Area: Windurst Woods
--  NPC: Iya Rihyo
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(419)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
