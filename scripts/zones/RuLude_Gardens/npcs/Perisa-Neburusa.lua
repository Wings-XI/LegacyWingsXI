-----------------------------------
-- Area: Ru'Lude Gardens
--   NPC: Perisa-Neburusa
-- Type: Residence Renter
-- !pos 54.651 8.999 -74.372 243
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(76)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tryMoveToLeaderMH(player)
end
