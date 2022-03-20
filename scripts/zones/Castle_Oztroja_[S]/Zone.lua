-----------------------------------
--
-- Zone: Castle_Oztroja_[S] (99)
--
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.DUU_MASA_THE_ONECUT)
    UpdateNMSpawnPoint(ID.mob.DEE_ZELKO_THE_ESOTERIC)
    UpdateNMSpawnPoint(ID.mob.MARQUIS_FORNEUS)
    UpdateNMSpawnPoint(ID.mob.LOO_KUTTO_THE_PENSIVE)
    UpdateNMSpawnPoint(ID.mob.FLESHGNASHER)
    UpdateNMSpawnPoint(ID.mob.VEE_LADU_THE_TITTERER)
    UpdateNMSpawnPoint(ID.mob.MAA_ILLMU_THE_BESTOWER)
    UpdateNMSpawnPoint(ID.mob.ASTERION)
    UpdateNMSpawnPoint(ID.mob.SUU_XICU_THE_CANTABILE)

    local dee_zelko_respawn = GetServerVariable("Dee_Zelko_Respawn")
    local forneus_respawn = GetServerVariable("Marquis_Forneus_Respawn")
    local loo_kutto_respawn = GetServerVariable("Loo_Kutto_Respawn")
    local fleshgnasher_respawn = GetServerVariable("Fleshgnasher_Respawn")
    local vee_ladu_respawn = GetServerVariable("Vee_Ladu_Respawn")
    local maa_ilmu_respawn = GetServerVariable("Maa_Illmu_Respawn")
    local asterion_respawn = GetServerVariable("Asterion_Respawn")
    local suu_xicu_respawn = GetServerVariable("Suu_Xicu_Respawn")
	if os.time() < suu_xicu_respawn then
		GetMobByID(ID.mob.SUU_XICU_THE_CANTABILE):setRespawnTime(suu_xicu_respawn - os.time())
	else
		SpawnMob(ID.mob.SUU_XICU_THE_CANTABILE)
    end
	if os.time() < asterion_respawn then
		GetMobByID(ID.mob.ASTERION):setRespawnTime(asterion_respawn - os.time())
	else
		SpawnMob(ID.mob.ASTERION)
    end
	if os.time() < maa_ilmu_respawn then
		GetMobByID(ID.mob.MAA_ILLMU_THE_BESTOWER):setRespawnTime(maa_ilmu_respawn - os.time())
	else
		SpawnMob(ID.mob.MAA_ILLMU_THE_BESTOWER)
    end
	if os.time() < vee_ladu_respawn then
		GetMobByID(ID.mob.VEE_LADU_THE_TITTERER):setRespawnTime(vee_ladu_respawn - os.time())
	else
		SpawnMob(ID.mob.VEE_LADU_THE_TITTERER)
    end
	if os.time() < fleshgnasher_respawn then
		GetMobByID(ID.mob.FLESHGNASHER):setRespawnTime(fleshgnasher_respawn - os.time())
	else
		SpawnMob(ID.mob.FLESHGNASHER)
    end
	if os.time() < loo_kutto_respawn then
		GetMobByID(ID.mob.LOO_KUTTO_THE_PENSIVE):setRespawnTime(loo_kutto_respawn - os.time())
	else
		SpawnMob(ID.mob.LOO_KUTTO_THE_PENSIVE)
    end
	if os.time() < forneus_respawn then
		GetMobByID(ID.mob.MARQUIS_FORNEUS):setRespawnTime(forneus_respawn - os.time())
	else
		SpawnMob(ID.mob.MARQUIS_FORNEUS)
    end
	if os.time() < dee_zelko_respawn then
		GetMobByID(ID.mob.DEE_ZELKO_THE_ESOTERIC):setRespawnTime(dee_zelko_respawn - os.time())
	else
		SpawnMob(ID.mob.DEE_ZELKO_THE_ESOTERIC)
    end

end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-239.447, -1.813, -19.98, 250)
    end
	if player:getCharVar("ManifestProblem") == 1 then
		cs = 100
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
	if csid == 100 then
		player:setCharVar("ManifestProblem",2)
	end
end
