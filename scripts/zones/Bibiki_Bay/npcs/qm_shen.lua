-----------------------------------
-- Area:  Bibiki Bay
-- NPC:   ??? (qm1)
-- Notes: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")

function onTrade(player, npc, trade)
	local shen = 16793859
	local fil1 = 16793860
	local fil2 = 16793861
    if ((not GetMobByID(shen):isSpawned()) and trade:hasItemQty(1823, 1) and trade:getItemCount() == 1) then
        player:tradeComplete()
        SpawnMob(shen):updateClaim(player)
		if not GetMobByID(fil1):isSpawned() then
			SpawnMob(fil1):updateClaim(player)
		end
		if not GetMobByID(fil2):isSpawned() then
			SpawnMob(fil2):updateClaim(player)
		end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
