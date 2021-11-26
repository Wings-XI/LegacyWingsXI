-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Gates of Halvung
-- !pos East Gate
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.CAST_METAL_PLATE) then
		player:messageSpecial(ID.text.OPEN_GATES, tpz.ki.CAST_METAL_PLATE)
		npc:openDoor(15)
	else 
		player:messageSpecial(ID.text.GATES_OF_HALVUNG)
		player:setCharVar("HalvungEast", 1)
	end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
