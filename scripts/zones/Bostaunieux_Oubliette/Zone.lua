-----------------------------------
--
-- Zone: Bostaunieux_Oubliette (167)
--
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/conquest")
require("scripts/globals/world")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.DREXERION_THE_CONDEMNED)
    GetMobByID(ID.mob.DREXERION_THE_CONDEMNED):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.PHANDURON_THE_CONDEMNED)
    GetMobByID(ID.mob.PHANDURON_THE_CONDEMNED):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.BLOODSUCKER)
    local bloodre = GetServerVariable("BloodRespawn")

	if os.time() < bloodre then
		GetMobByID(ID.mob.BLOODSUCKER):setRespawnTime(bloodre - os.time())
    else
        SpawnMob(ID.mob.BLOODSUCKER)
	end

    local hour = VanadielHour()

    if hour < 6 or hour >= 18 then
        DisallowRespawn(ID.mob.SHII, false)
    else
        DisallowRespawn(ID.mob.SHII, true)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(99.978, -25.647, 72.867, 61)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onGameHour()
    local hour = VanadielHour()

    if hour < 6 or hour >= 18 then
        DisallowRespawn(ID.mob.SHII, false)
    else
        DisallowRespawn(ID.mob.SHII, true)
    end
end