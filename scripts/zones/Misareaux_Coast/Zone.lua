-----------------------------------
--
-- Zone: Misareaux_Coast (25)
--
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/helm")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
local MISAREAUX_COAST = require("scripts/zones/Misareaux_Coast/globals")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
    MISAREAUX_COAST.ziphiusHandleQM()

    UpdateNMSpawnPoint(ID.mob.ODQAN)
    local Odqan = GetMobByID(ID.mob.ODQAN)
    DisallowRespawn(Odqan:getID(), true) -- prevents accidental 'pop' during no fog and immediate despawn
    local upyri_respawn = GetServerVariable("Upyri_Respawn")
	if os.time() < upyri_respawn then
		GetMobByID(ID.mob.UPYRI):setRespawnTime(upyri_respawn - os.time())
	else
		SpawnMob(ID.mob.UPYRI)
    end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(567.624, -20, 280.775, 120)
    end
    return cs
end

function onRegionEnter(player, region)
end

function onGameHour(zone)
    local vHour = VanadielHour()
    if vHour >= 22 or vHour <= 7 then
        MISAREAUX_COAST.ziphiusHandleQM()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onZoneWeatherChange(weather)
    UpdateNMSpawnPoint(ID.mob.ODQAN)
    local odqanre = GetServerVariable("OdqanRespawn")
    local Odqan = GetMobByID(ID.mob.ODQAN)

    if
        not Odqan:isSpawned() and os.time() > odqanre
        and weather == tpz.weather.FOG
    then
        DisallowRespawn(Odqan:getID(), false)
        Odqan:setRespawnTime(math.random(15, 90)) -- pop 15-90 sec after fog starts (FOG can be pretty short)
    elseif not weather == tpz.weather.FOG then
        DisallowRespawn(Odqan:getID(), true)
    end
end
