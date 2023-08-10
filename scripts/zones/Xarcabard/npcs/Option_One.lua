-----------------------------------
-- Area: Xarcabard
--  NPC: Option One
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner - Puzzle 2
-- !pos 126.091 -23.615 -118.026 112
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    amkHelpers.puzzleTwoOnEventTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    amkHelpers.puzzleTwoOnEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    amkHelpers.puzzleTwoOnEventFinish(player, csid, option)
end
