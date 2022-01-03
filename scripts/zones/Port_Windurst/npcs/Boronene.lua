-----------------------------------
-- Area: Port Windurst
--   NPC: Boronene
-- Type: Moghouse Renter
-- !pos 201.651 -13 229.584 240
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    rrOnTrigger(player, npc, 638)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    rrOnEventFinish(player, csid, option)
end
