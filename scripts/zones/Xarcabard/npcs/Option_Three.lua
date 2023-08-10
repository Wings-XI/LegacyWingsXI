-----------------------------------
-- Area: Xarcabard
--  NPC: Option Three
-- Involved in Mission: AMK 13 -  A Challenge! You Could Be a Winner - Puzzle 2
-- !pos 1.130 -23.180 -103.599 112
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
