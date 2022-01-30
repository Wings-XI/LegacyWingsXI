-----------------------------------
-- Area: Port Jeuno
--  NPC: Yurugu Homurugu
-- Standard Info NPC
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(21, 3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
