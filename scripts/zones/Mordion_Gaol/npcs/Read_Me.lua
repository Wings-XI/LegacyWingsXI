-----------------------------------
-- Area: Mordion Gaol
--  NPC: Read Me
-- Standard Info NPC
-----------------------------------

local ID = require("scripts/zones/Mordion_Gaol/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.PROHIBITED_ACTIVITIES)
    player:showText(npc, ID.text.DEPENDANT_UPON_OUTCOME)
    player:showText(npc, ID.text.ONCE_YOUR_SUSPENSION)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
