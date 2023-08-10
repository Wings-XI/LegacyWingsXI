-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Southwestern Pip
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos -90.000 -40.000 -210.000 111
-- ID: 17232301
-----------------------------------
require("scripts/globals/events/amkhelpers")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    amkHelpers.pipTrigger(player, npc, 3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
