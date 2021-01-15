-----------------------------------
-- Area: Grauberg (S)
--  NPC: Vanja
-- !pos -287.852 14.222 -525.023 89
-- Involved in Quest: Witchfire Glen
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
	player:startEvent(9) -- Default text
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end