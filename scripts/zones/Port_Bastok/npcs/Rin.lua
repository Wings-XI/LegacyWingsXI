-----------------------------------
-- Area: Port Bastok
--  NPC: Rin
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/events/starlight_festivals")
------------------------------------

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(36)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
