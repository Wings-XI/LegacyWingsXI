-----------------------------------
--
-- Zone: Phomiuna_Aqueducts (27)
--
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    -- FFXI wiki has vague info of ~10mins realtime for Phomiuna Aqueducts
    GetNPCByID(ID.npc.SECRETS_OF_OVENS_LOST_QM):addPeriodicTrigger(0,250,0)
    local eba_respawn = GetServerVariable("Eba_Respawn")
    local mahisha_respawn = GetServerVariable("Mahisha_Respawn")
    local duendes_respawn = GetServerVariable("Tres_Duendes_Respawn")
	if os.time() < duendes_respawn then
		GetMobByID(ID.mob.TRES_DUENDES):setRespawnTime(duendes_respawn - os.time())
	else
		SpawnMob(ID.mob.TRES_DUENDES)
    end
	if os.time() < mahisha_respawn then
		GetMobByID(ID.mob.MAHISHA):setRespawnTime(mahisha_respawn - os.time())
	else
		SpawnMob(ID.mob.MAHISHA)
    end
	if os.time() < eba_respawn then
		GetMobByID(ID.mob.EBA):setRespawnTime(eba_respawn - os.time())
	else
		SpawnMob(ID.mob.EBA)
    end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(260.02, -2.12, -290.461, 192)
    end

    return cs
end

function afterZoneIn(player)
    if (ENABLE_COP_ZONE_CAP == 1) then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 40, 0, 0) -- LV40 cap
    end
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
