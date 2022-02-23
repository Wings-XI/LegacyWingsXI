-----------------------------------
--
-- Zone: Valkurm_Dunes (103)
--
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    tpz.conq.setRegionalConquestOverseers(zone:getRegionID(), 2)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(60.989, -4.898, -151.001, 198)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3;
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==
        1) then
        cs = 5
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if (csid == 3) then
        quests.rainbow.onEventUpdate(player)
    elseif (csid == 5) then
        if (player:getZPos() > 45) then
            if (player:getZPos() > -301) then
                player:updateEvent(0, 0, 0, 0, 0, 1)
            else
                player:updateEvent(0, 0, 0, 0, 0, 3)
            end
        end
    end
end

function onEventFinish(player, csid, option)
end

function onZoneWeatherChange(weather)
    local qm1 = GetNPCByID(ID.npc.SUNSAND_QM) -- Quest: An Empty Vessel
    if (weather == tpz.weather.DUST_STORM) then
        qm1:setStatus(tpz.status.NORMAL)
    else
        qm1:setStatus(tpz.status.DISAPPEAR)
    end
end

function onGameHour(zone)
    local currentTime = VanadielHour()
    local npc = GetNPCByID(ID.npc.QM_WHMAF) -- WHM AF ??? Spawned between 18 to 5

    if (npc ~= nil) then
        if currentTime >= 18 or currentTime <= 5 then
            npc:setStatus(tpz.status.NORMAL)
        else
            npc:setStatus(tpz.status.DISAPPEAR)
        end
    end
end