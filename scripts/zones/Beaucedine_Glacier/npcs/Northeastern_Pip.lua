-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Northeastern Pip
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos 10.000 -60.850 -10.000 111
-- ID: 17232302
-----------------------------------
require("scripts/globals/events/amkhelpers")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    amkHelpers.pipTrigger(player, npc, 4)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
