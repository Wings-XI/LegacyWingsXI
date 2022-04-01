-----------------------------------
--
-- Zone: Arrapago_Reef (54)
--
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -462, -4, -420, -455, -1, -392) -- approach the Cutter
    local euryale_respawn = GetServerVariable("Euryale_Respawn")
    local lamieno7_respawn = GetServerVariable("Lamie_No7_Respawn")
    local lamieno8_respawn = GetServerVariable("Lamie_No8_Respawn")
    local lamieno9_respawn = GetServerVariable("Lamie_No9_Respawn")
    local medusa_respawn = GetServerVariable("Medusa_Respawn")
    local merrowno5_respawn = GetServerVariable("Merrow_No5_Respawn")
    if os.time() < merrowno5_respawn then
		GetMobByID(ID.mob.MERROW_NO5):setRespawnTime(merrowno5_respawn - os.time())
	else
		SpawnMob(ID.mob.MERROW_NO5)
    end
    if os.time() < medusa_respawn then
		GetMobByID(ID.mob.MEDUSA):setRespawnTime(medusa_respawn - os.time())
	else
		SpawnMob(ID.mob.MEDUSA)
    end
    if os.time() < lamieno7_respawn then
		GetMobByID(ID.mob.LAMIE_NO7):setRespawnTime(lamieno7_respawn - os.time())
	else
		SpawnMob(ID.mob.LAMIE_NO7)
    end
    if os.time() < lamieno8_respawn then
		GetMobByID(ID.mob.LAMIE_NO8):setRespawnTime(lamieno8_respawn - os.time())
	else
		SpawnMob(ID.mob.LAMIE_NO8)
    end
    if os.time() < lamieno9_respawn then
		GetMobByID(ID.mob.LAMIE_NO9):setRespawnTime(lamieno9_respawn - os.time())
	else
		SpawnMob(ID.mob.LAMIE_NO9)
    end
    if os.time() < euryale_respawn then
		GetMobByID(ID.mob.EURYALE):setRespawnTime(euryale_respawn - os.time())
	else
		SpawnMob(ID.mob.EURYALE)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-456, -3, -405, 64)
    end

    if prevZone == tpz.zone.THE_ASHU_TALIF then
        if player:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_BLACK_COFFIN and player:getCharVar("AhtUrganStatus") == 2 then
            player:setPos(-456, -3, -405, 64)
            cs = 9
        elseif player:getCharVar("AgainstAllOdds") == 3 then
            cs = 238
        end
    elseif prevZone == tpz.zone.CAEDARVA_MIRE then
        if player:getCurrentMission(TOAU) == tpz.mission.id.toau.PREVALENCE_OF_PIRATES and player:getCharVar("AhtUrganStatus") == 0 then
            cs = 13
        end
    elseif prevZone == tpz.zone.ILRUSI_ATOLL then
        player:setPos(26, -7, 606, 222)
    end
    return cs
end

function afterZoneIn(player)
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_BLACK_COFFIN and player:hasKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN) and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(8)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PREVALENCE_OF_PIRATES and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(14)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.TESTING_THE_WATERS and player:hasKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN)) then
        player:startEvent(15)
    elseif (player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == QUEST_ACCEPTED and player:getCharVar("AgainstAllOdds") == 1) then
        player:startEvent(237)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 8) then
        player:setCharVar("AhtUrganStatus", 1)
        player:startEvent(34, 1, 1, 1, 1, 1, 1, 1, 1)
    elseif (csid == 9) then
        player:setCharVar("AhtUrganStatus", 3)
        player:setPos(0, 0, 0, 0, 53)
    elseif (csid == 13) then
        player:setCharVar("AhtUrganStatus", 1)
    elseif (csid == 14) then
        player:completeMission(TOAU, tpz.mission.id.toau.PREVALENCE_OF_PIRATES)
        player:setCharVar("AhtUrganStatus", 0)
        player:addKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
        player:addMission(TOAU, tpz.mission.id.toau.SHADES_OF_VENGEANCE)
    elseif (csid == 15) then
        player:setCharVar("AhtUrganStatus", 1)
        player:setPos(0, 0, 0, 0, 57)
    elseif (csid == 34 and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(35)
    elseif (csid == 108) then -- enter instance: illrusi atoll
        player:setPos(0, 0, 0, 0, 55)
    elseif (csid == 222) then -- enter instance: the ashu talif
        player:setPos(0, 0, 0, 0, 60)
    elseif (csid == 237) then
        player:startEvent(240)
    elseif csid == 238 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS, { item=15266, var="AgainstAllOdds"})
    elseif (csid == 240) then
        player:setCharVar("AgainstAllOdds", 2)
    end
end
