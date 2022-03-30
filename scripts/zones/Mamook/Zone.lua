-----------------------------------
--
-- Zone: Mamook (65)
--
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
require("scripts/globals/conquest")
require("scripts/globals/helm")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
    local kachaal_respawn = GetServerVariable("Darting_Kachaal_Ja_Respawn")
    local dragonscaled_respawn = GetServerVariable("Dragonscaled_Bugaal_Respawn")
    local gulool_respawn = GetServerVariable("Gulool_Ja_Ja_Respawn")
    local hundredfaced_respawn = GetServerVariable("Hundredfaced_Hapool_Ja_Respawn")
	if os.time() < hundredfaced_respawn then
		GetMobByID(ID.mob.HUNDREDFACED_HAPOOL_JA):setRespawnTime(hundredfaced_respawn - os.time())
	else
		SpawnMob(ID.mob.HUNDREDFACED_HAPOOL_JA)
    end
	if os.time() < gulool_respawn then
		GetMobByID(ID.mob.GULOOL_JA_JA):setRespawnTime(gulool_respawn - os.time())
	else
		SpawnMob(ID.mob.GULOOL_JA_JA)
    end
	if os.time() < dragonscaled_respawn then
		GetMobByID(ID.mob.DRAGONSCALED_BUGAAL_JA):setRespawnTime(dragonscaled_respawn - os.time())
	else
		SpawnMob(ID.mob.DRAGONSCALED_BUGAAL_JA)
    end
	if os.time() < kachaal_respawn then
		GetMobByID(ID.mob.DARTING_KACHAAL_JA):setRespawnTime(kachaal_respawn - os.time())
	else
		SpawnMob(ID.mob.DARTING_KACHAAL_JA)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-117.491, -20.115, -299.997, 6)
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
