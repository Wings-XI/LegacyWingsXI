-----------------------------------
--
-- Zone: East_Ronfaure_[S] (81)
--
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure_[S]/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/helm")
require("scripts/globals/zone")
require("scripts/globals/events/dark_ixion")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.MYRADROSH)
    GetMobByID(ID.mob.MYRADROSH):setRespawnTime(math.random(5400, 7200))

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
    local melusine_respawn = GetServerVariable("Melusine_Respawn")
    if os.time() < melusine_respawn then
		GetMobByID(ID.mob.MELUSINE):setRespawnTime(melusine_respawn - os.time())
	else
		SpawnMob(ID.mob.MELUSINE)
    end
    darkixion.onZoneInit(zone)
end

function onGameHour(zone)
	darkixion.onZoneGameHour(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(86.131, -65.817, 273.861, 25)
    end
    if (prevZone == tpz.zone.SOUTHERN_SAN_DORIA_S) then
        if (player:getCurrentMission(WOTG) == tpz.mission.id.wotg.WHILE_THE_CAT_IS_AWAY) then
            cs = 7
        end
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
    if (csid == 7) then
        player:completeMission(WOTG, tpz.mission.id.wotg.WHILE_THE_CAT_IS_AWAY)
        player:addMission(WOTG, tpz.mission.id.wotg.A_TIMESWEPT_BUTTERFLY)
    end
end
