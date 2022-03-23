-----------------------------------
-- Area: Bastok Markets
--   NPC: Loulia
-- Type: Room Renters
-- !pos -176.212 -9 -25.049 235
--
-- Auto-Script: Requires Verification. Validated standard dialog - thrydwolf 12/8/2011
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    rrOnTrigger(player, npc, 487)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    rrOnEventFinish(player, csid, option)
end
