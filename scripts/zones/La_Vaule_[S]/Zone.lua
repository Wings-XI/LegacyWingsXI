-----------------------------------
--
-- Zone: La_Vaule_[S] (85)
--
-----------------------------------
local ID = require("scripts/zones/La_Vaule_[S]/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
require("scripts/globals/titles")
-----------------------------------

function onInitialize(zone)
    local agrios_respawn = GetServerVariable("Agrios_Respawn")
    local all_seeing_respawn = GetServerVariable("All-Seeing_Respawn")
    local cogtooth_respawn = GetServerVariable("Cogtooth_Skagnogg_Respawn")
    local coinbiter_respawn = GetServerVariable("Coinbiter_Cjaknokk_Respawn")
    local draketrader_respawn = GetServerVariable("Draketrader_Zlodgodd__Respawn")
    local falsespinner_respawn = GetServerVariable("Falsespinner_Bhudbrodd_Respawn")
    local feeblescheme_respawn = GetServerVariable("Feeblescheme_Bhogbigg_Respawn")
    local rugaroo_respawn = GetServerVariable("Rugaroo_Respawn")
	if os.time() < rugaroo_respawn then
		GetMobByID(ID.mob.RUGAROO):setRespawnTime(rugaroo_respawn - os.time())
	else
		SpawnMob(ID.mob.RUGAROO)
    end
	if os.time() < feeblescheme_respawn then
		GetMobByID(ID.mob.FEEBLESCHEME_BHOGBIGG):setRespawnTime(feeblescheme_respawn - os.time())
	else
		SpawnMob(ID.mob.FEEBLESCHEME_BHOGBIGG)
    end
	if os.time() < falsespinner_respawn then
		GetMobByID(ID.mob.FALSESPINNER_BHUDBRODD):setRespawnTime(falsespinner_respawn - os.time())
	else
		SpawnMob(ID.mob.FALSESPINNER_BHUDBRODD)
    end
	if os.time() < draketrader_respawn then
		GetMobByID(ID.mob.DRAKETRADER_ZLODGODD):setRespawnTime(draketrader_respawn - os.time())
	else
		SpawnMob(ID.mob.DRAKETRADER_ZLODGODD)
    end
	if os.time() < agrios_respawn then
		GetMobByID(ID.mob.AGRIOS):setRespawnTime(agrios_respawn - os.time())
	else
		SpawnMob(ID.mob.AGRIOS)
    end
    if os.time() < all_seeing_respawn then
		GetMobByID(ID.mob.ALL_SEEING):setRespawnTime(all_seeing_respawn - os.time())
	else
		SpawnMob(ID.mob.ALL_SEEING)
    end
    if os.time() < cogtooth_respawn then
		GetMobByID(ID.mob.COGTOOTH_SKAGNOGG):setRespawnTime(cogtooth_respawn - os.time())
	else
		SpawnMob(ID.mob.COGTOOTH_SKAGNOGG)
    end
    if os.time() < coinbiter_respawn then
		GetMobByID(ID.mob.COINBITER_CJAKNOKK):setRespawnTime(coinbiter_respawn - os.time())
	else
		SpawnMob(ID.mob.COINBITER_CJAKNOKK)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(236.547, -2.25, 20, 120)
    end
    if player:getCurrentMission(WOTG) == tpz.mission.id.wotg.A_TIMESWEPT_BUTTERFLY and prevZone == tpz.zone.JUGNER_FOREST_S then
        cs = 1
    elseif player:getCurrentMission(WOTG) == tpz.mission.id.wotg.PURPLE_THE_NEW_BLACK and player:getCharVar("PurpleTheNewBlackProgress") == 2 then
        cs = 6
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
    if csid == 1 then
        player:completeMission(WOTG, tpz.mission.id.wotg.A_TIMESWEPT_BUTTERFLY)
        player:addMission(WOTG, tpz.mission.id.wotg.PURPLE_THE_NEW_BLACK)
    elseif csid == 6 then
        player:completeMission(WOTG, tpz.mission.id.wotg.PURPLE_THE_NEW_BLACK)
        player:setCharVar("PurpleTheNewBlackProgress", 0)
        player:addTitle(tpz.title.TRAVERSER_OF_TIME)
        player:addMission(WOTG, tpz.mission.id.wotg.IN_THE_NAME_OF_THE_FATHER)
        player:PrintToPlayer("WotG mission progress stops here for now.", 0x1F)
    end
end
