-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Zhamwaa
-- Standard Info NPC
-----------------------------------

require("scripts/globals/room_rental")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    rrOnTrigger(player, npc, 500, 7)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- No open mog here
    -- rrOnEventFinish(player, csid, option)
end
