-----------------------------------
--
-- Zone: Maze of Shakhrami (198)
--
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
	local re = GetServerVariable("ArgusRespawn")
	if os.time() < re then
		if math.random(2) == 1 then
			DisallowRespawn(ID.mob.LEECH_KING, true)
			DisallowRespawn(ID.mob.ARGUS, false)
			UpdateNMSpawnPoint(ID.mob.ARGUS)
			GetMobByID(ID.mob.ARGUS):setRespawnTime(re - os.time())
		else
			DisallowRespawn(ID.mob.ARGUS, true)
			DisallowRespawn(ID.mob.LEECH_KING, false)
			UpdateNMSpawnPoint(ID.mob.LEECH_KING)
			GetMobByID(ID.mob.LEECH_KING):setRespawnTime(re - os.time())
		end
	else
		if math.random(2) == 1 then
			DisallowRespawn(ID.mob.LEECH_KING, true)
			DisallowRespawn(ID.mob.ARGUS, false)
			UpdateNMSpawnPoint(ID.mob.ARGUS)
			SpawnMob(ID.mob.ARGUS)
		else
			DisallowRespawn(ID.mob.ARGUS, true)
			DisallowRespawn(ID.mob.LEECH_KING, false)
			UpdateNMSpawnPoint(ID.mob.LEECH_KING)
			SpawnMob(ID.mob.LEECH_KING)
		end
	end

    tpz.treasure.initZone(zone)
    tpz.helm.initZone(zone, tpz.helm.type.EXCAVATION)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-140.246, -12.738, 160.709, 63)
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
