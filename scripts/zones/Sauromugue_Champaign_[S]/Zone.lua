-----------------------------------
--
-- Zone: Sauromugue_Champaign_[S] (98)
--
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign_[S]/IDs")
require("scripts/globals/conquest")
require("scripts/globals/quests")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.COQUECIGRUE)
    local coquecigrue_respawn = GetServerVariable("Coquecigrue_Respawn")
	if os.time() < coquecigrue_respawn then
		GetMobByID(ID.mob.COQUECIGRUE):setRespawnTime(coquecigrue_respawn - os.time())
	else
		SpawnMob(ID.mob.COQUECIGRUE)
    end
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-104, -25.36, -410, 195)
    end
    if (prevZone == tpz.zone.ROLANBERRY_FIELDS_S and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX) == QUEST_ACCEPTED and player:getCharVar("DownwardHelix") == 2) then
        cs = 3
    end
	if player:getCharVar("WOTG_PlayCrashLandCS") == 1 then
		cs = 700
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
    if (csid == 3) then
        player:setCharVar("DownwardHelix", 3)
    end
	if csid == 700 then
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PURE_WHITE_FEATHER)
		player:setCharVar("WOTG_PlayCrashLandCS",0)
	end
end
