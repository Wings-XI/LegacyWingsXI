-----------------------------------
-- Area: Mordion Gaol
--  NPC: Read Me
-- Standard Info NPC
-----------------------------------

local ID = require("scripts/zones/Mordion_Gaol/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(103)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
