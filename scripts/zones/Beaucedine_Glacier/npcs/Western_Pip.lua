-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Western Pip
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos -90.000 -61.350 -110.000 111
-- ID: 17232300 
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/events/amkhelpers")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    amkHelpers.pipTrigger(player, npc, 2)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end