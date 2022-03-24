-----------------------------------
--
-- Zone: Beadeaux_[S] (92)
--
-----------------------------------
local ID = require("scripts/zones/Beadeaux_[S]/IDs")
require("scripts/globals/conquest")
-----------------------------------

function onInitialize(zone)
    local blifnix_oilycheeks_respawn = GetServerVariable("Blifnix_Oilycheeks_Respawn")
    local bres_respawn = GetServerVariable("Bres_Respawn")
    local spongeshell_respawn = GetServerVariable("DiZho_Spongeshell_Respawn")
    local nevermolt_respawn = GetServerVariable("GaLhu_Nevermolt_Respawn")
    local thimbletail_respawn = GetServerVariable("MuNhi_Thimbletail_Respawn")
    local zekka_respawn = GetServerVariable("Observant_Zekka_Respawn")
    local scarscute_respawn = GetServerVariable("RaDha_Scarscute_Respawn")
    local bloodbasked_respawn = GetServerVariable("VaGho_Bloodbasked_Respawn")
    if os.time() < bloodbasked_respawn then
      GetMobByID(ID.mob.VA_GHO_BLOODBASKED):setRespawnTime(bloodbasked_respawn - os.time())
    else
      SpawnMob(ID.mob.VA_GHO_BLOODBASKED)
    end
    if os.time() < scarscute_respawn then
      GetMobByID(ID.mob.RA_DHA_SCARSCUTE):setRespawnTime(scarscute_respawn - os.time())
    else
      SpawnMob(ID.mob.RA_DHA_SCARSCUTE)
    end
    if os.time() < zekka_respawn then
      GetMobByID(ID.mob.OBSERVANT_ZEKKA):setRespawnTime(zekka_respawn - os.time())
    else
      SpawnMob(ID.mob.OBSERVANT_ZEKKA)
    end
    if os.time() < thimbletail_respawn then
      GetMobByID(ID.mob.MU_NHI_THIMBLETAIL):setRespawnTime(thimbletail_respawn - os.time())
    else
      SpawnMob(ID.mob.MU_NHI_THIMBLETAIL)
    end
    if os.time() < nevermolt_respawn then
		GetMobByID(ID.mob.GA_LHU_NEVERMOLT):setRespawnTime(nevermolt_respawn - os.time())
	else
		SpawnMob(ID.mob.GA_LHU_NEVERMOLT)
    end
    if os.time() < spongeshell_respawn then
		GetMobByID(ID.mob.DI_ZHO_SPONGESHELL):setRespawnTime(spongeshell_respawn - os.time())
	else
		SpawnMob(ID.mob.DI_ZHO_SPONGESHELL)
    end
	if os.time() < blifnix_oilycheeks_respawn then
		GetMobByID(ID.mob.BLIFNIX_OILYCHEEKS):setRespawnTime(blifnix_oilycheeks_respawn - os.time())
	else
		SpawnMob(ID.mob.BLIFNIX_OILYCHEEKS)
    end
    if os.time() < bres_respawn then
		GetMobByID(ID.mob.BRES):setRespawnTime(bres_respawn - os.time())
	else
		SpawnMob(ID.mob.BRES)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-297.109, 0.008, 96.002, 252)
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
