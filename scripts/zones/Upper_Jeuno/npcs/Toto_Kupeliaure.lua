-----------------------------------
-- Area: Upper Jeuno
--  NPC: Taylen
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
-----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local dumb_remarks = {
        12427,
        12430,
        12439,
    }
    player:messageSpecial(dumb_remarks[math.random(#dumb_remarks)])
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
