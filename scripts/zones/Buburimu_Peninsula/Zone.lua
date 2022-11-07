-----------------------------------
--
-- Zone: Buburimu_Peninsula (118)
--
-----------------------------------
local buburimuID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/zones/Buburimu_Peninsula/npcs/qm1")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/globals/zone")
require("scripts/globals/fishing/fishing_types")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    local hour = VanadielHour()
    local qm1 = GetNPCByID(buburimuID.npc.QM1)

    if hour >= 6 and hour < 16 then
        GetMobByID(buburimuID.mob.BACKOO):setRespawnTime(1)
    end

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID(), 2)

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
    
    npcs.qm1.initialize()
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( -276.529, 16.403, -324.519, 14)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1 then
        cs = 5 -- zone 4 buburimu no update (north)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onGameHour(zone)
    local hour = VanadielHour()
    local nmBackoo = GetMobByID(buburimuID.mob.BACKOO)
    local qm1 = GetNPCByID(buburimuID.npc.QM1)

    if hour == 6 then -- backoo time-of-day pop condition open
        DisallowRespawn(buburimuID.mob.BACKOO, false)
        if nmBackoo:getRespawnTime() == 0 then
            nmBackoo:setRespawnTime(1)
        end
    elseif hour == 16 then -- backoo despawns
        DisallowRespawn(buburimuID.mob.BACKOO, true)
        if nmBackoo:isSpawned() then
            nmBackoo:spawn(1)
        end
    end
    
    --If the Brigand's Chart Quest is still active, but the player zoned or disconnected, end the quest.
    if qm1:getLocalVar("BCQActive") == 1 then
        local playerID = qm1:getLocalVar("BCQPlayer")
        local player = GetPlayerByID(playerID)

        if player then
            if player:getLocalVar("BCQ") == 0 then
                npcs.qm1.endQuest(nil)
            end
        else
            npcs.qm1.endQuest(nil)
        end
    end
end


function onEventUpdate( player, csid, option)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 5 then
        if player:getPreviousZone() == tpz.zone.LABYRINTH_OF_ONZOZO or player:getPreviousZone() == tpz.zone.MHAURA then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        elseif player:getPreviousZone() == tpz.zone.MAZE_OF_SHAKHRAMI then
            player:updateEvent(0, 0, 0, 0, 0, 6)
        end
    end
end

function onEventFinish( player, csid, option)
end