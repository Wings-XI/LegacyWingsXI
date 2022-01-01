-----------------------------------
-- Area: Bastok Mines
--  NPC: Leonie
-- Type: Room Renters
-- !pos 118.871 -0.004 -83.916 234
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    rrOnTrigger(player, npc, 568)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    rrOnEventFinish(player, csid, option)
end
