-----------------------------------
-- Area: Port Bastok
--  NPC: Wurteh
-- Standard Info NPC
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(95)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tryMoveToLeaderMH(player)
end
