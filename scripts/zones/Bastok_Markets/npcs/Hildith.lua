-----------------------------------
-- Area: Bastok Markets
--  NPC: Hildith
-- Type: Room Renters
-- !pos -176.664 -9 25.158 235
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(488)
end;

function onEventUpdate(player, csid, option)
end;

function onEventFinish(player, csid, option)
    tryMoveToLeaderMH(player)
end
