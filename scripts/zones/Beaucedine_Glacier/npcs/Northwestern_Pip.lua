-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Northwestern Pip
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos -90.000 -100.000 -10.000 111
-- ID: 17232299
-----------------------------------
require("scripts/globals/events/amkhelpers")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    amkHelpers.pipTrigger(player, npc, 1)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
