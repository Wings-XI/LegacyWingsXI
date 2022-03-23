-----------------------------------
-- Area: Windurst Walls
--   NPC: Shinchai-Tocchai
-- Type: Moghouse Renter
-- !pos -220.551 -0.001 -116.916 239
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    rrOnTrigger(player, npc, 505)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    rrOnEventFinish(player, csid, option)
end
