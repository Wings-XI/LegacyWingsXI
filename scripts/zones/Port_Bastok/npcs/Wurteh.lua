-----------------------------------
-- Area: Port Bastok
--  NPC: Wurteh
-- Standard Info NPC
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    rrOnTrigger(player, npc, 382)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    rrOnEventFinish(player, csid, option)
end
