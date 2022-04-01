-----------------------------------
--
-- Zone: Den_of_Rancor (160)
--
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
-----------------------------------

function onInitialize(zone)
    tpz.treasure.initZone(zone)
    local pontifex_respawn = GetServerVariable("Pontifex_Respawn")
    if os.time() < pontifex_respawn then
		GetMobByID(ID.mob.TONBERRY_PONTIFEX):setRespawnTime(pontifex_respawn - os.time())
	else
		SpawnMob(ID.mob.TONBERRY_PONTIFEX)
    end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(196.421, 34.595, -60.319, 110)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
