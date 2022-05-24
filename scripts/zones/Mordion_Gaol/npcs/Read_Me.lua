-----------------------------------
-- Area: Mordion Gaol
--  NPC: Read Me
-- Standard Info NPC
-----------------------------------

local ID = require("scripts/zones/Mordion_Gaol/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:PrintToPlayer("You are jailed under suspicion of breaking the Terms of Service. Please submit a GM Ticket in the Wings Discord.",29)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
