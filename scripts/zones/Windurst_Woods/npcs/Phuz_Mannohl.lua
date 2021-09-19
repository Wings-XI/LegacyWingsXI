-----------------------------------
-- Area: Windurst Woods
--  NPC: Phuz Mannohl
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(344)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
