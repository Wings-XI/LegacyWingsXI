-----------------------------------
-- Area: Al Zahbi
--  NPC: Krujaal
-- Type: Residence Renter
-- !pos 36.522 -1 -63.198 48
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tryMoveToLeaderMH(player)
end
