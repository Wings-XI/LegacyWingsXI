-----------------------------------
--
-- Zone: The_Eldieme_Necropolis_[S] (175)
--
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
    local ethniu_respawn = GetServerVariable("Ethniu_Respawn")
    local tethra_respawn = GetServerVariable("Tethra_Respawn")
    if os.time() < tethra_respawn then
		GetMobByID(ID.mob.TETHRA):setRespawnTime(tethra_respawn - os.time())
	else
		SpawnMob(ID.mob.TETHRA)
    end
    if os.time() < ethniu_respawn then
		GetMobByID(ID.mob.ETHNIU):setRespawnTime(ethniu_respawn - os.time())
	else
		SpawnMob(ID.mob.ETHNIU)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(420.035, -58.114, -119.51, 191)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
