-----------------------------------
-- Area: Port Windurst
--  NPC: Mov Lingyoh
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/events/starlight_festivals")
-----------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(345)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
