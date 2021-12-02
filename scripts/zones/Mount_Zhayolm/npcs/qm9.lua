-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Cast Metal Plate) 
--	ID 17027568
-- !pos 152.6540 	-14.2256 	-146.7709
--		258.4493	-16.2094	-220.9087
--		389.5214	-14.3110	-228.9190
--		462.3387	-15.5414	-59.2175
--		600.1025	-17.8908	14.2162
--		732.7904	-22.9902	19.1166
--		617.6666	-24.0545	102.9118
--		570.8515	-25.2351	212.2957
--		789.2047	-21.8835	329.7796
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
	if player:getCharVar("HalvungWest") == 1 or player:getCharVar("HalvungEast") == 1 then
		player:addKeyItem(tpz.ki.CAST_METAL_PLATE)
		player:messageSpecial(ID.text.CAST_METAL_PLATE, tpz.ki.CAST_METAL_PLATE)
		player:setCharVar("HalvungWest", 0)
		player:setCharVar("HalvungEast", 0)

		local NextSpawn = math.random(1,9)

		if NextSpawn == 1 then
			npc:setPos(152.354, -14.225, -146.770)
		elseif NextSpawn == 2 then
			npc:setPos(258.449,	-16.209, -220.908)
		elseif NextSpawn == 3 then
			npc:setPos(389.521, -14.311, -228.919)
		elseif NextSpawn == 4 then
			npc:setPos(462.338, -15.541, -59.217)
		elseif NextSpawn == 5 then
			npc:setPos(600.102, -17.890, 14.216)
		elseif NextSpawn == 6 then
			npc:setPos(732.790,	-22.990, 19.116)
		elseif NextSpawn == 7 then
			npc:setPos(617.666, -24.054, 102.911)
		elseif NextSpawn == 8 then
			npc:setPos(570.851,	-25.235, 212.295)
		elseif NextSpawn == 9 then
			npc:setPos(789.204,	-21.883, 329.779)
		end
		
	else
		player:messageSpecial(ID.text.ORDINARY)
	end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(npc)

end