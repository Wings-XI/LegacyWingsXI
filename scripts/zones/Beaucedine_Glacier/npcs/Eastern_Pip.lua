-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Eastern Pip
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner
-- !pos 10.000 -60.200 -110.000 111
-- ID: 17232303
-----------------------------------
require("scripts/globals/events/amkhelpers")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    amkHelpers.pipTrigger(player, npc, 5)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
