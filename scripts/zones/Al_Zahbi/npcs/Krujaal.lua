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
    rrOnTrigger(player, npc, 0, 7)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- No open mog in this zone
    -- rrOnEventFinish(player, csid, option)
end
