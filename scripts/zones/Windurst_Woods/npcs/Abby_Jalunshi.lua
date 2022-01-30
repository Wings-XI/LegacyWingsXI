-----------------------------------
-- Area: Windurst Woods
--   NPC: Abby Jalunshi
-- Type: Moghouse Renter
-- !pos -101.895 -5 36.172 241
--
-- Auto-Script: Requires Verification (Verfied By Brawndo)
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    rrOnTrigger(player, npc, 798)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    rrOnEventFinish(player, csid, option)
end
