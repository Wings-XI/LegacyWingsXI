-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Towering Portcullis
-- Notes: Used to exit cait sith battle
-- !gotoid 17523216
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/quests")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    EventTriggerBCNM(player, npc)
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    EventFinishBCNM(player, csid, option)
end
