-----------------------------------
-- Area: Grauberg (S)
--  NPC: Childerich
-- !pos -310.702 14.222 -526.532 89
-- Involved in Quest: Witchfire Glen
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
	player:startEvent(8) -- Default text
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end