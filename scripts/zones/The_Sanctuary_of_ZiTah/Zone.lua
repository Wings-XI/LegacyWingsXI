-----------------------------------
--
-- Zone: The_Sanctuary_of_ZiTah (121)
--
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    GetMobByID(ID.mob.NOBLE_MOLD):setLocalVar("pop", os.time() + math.random(43200, 57600)) -- 12 to 16 hr

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID(), 2)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(539.901, 3.379, -580.218, 126)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 4
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 4 then
        if player:getPreviousZone() == tpz.zone.THE_BOYAHDA_TREE then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        elseif player:getPreviousZone() == tpz.zone.MERIPHATAUD_MOUNTAINS then
            player:updateEvent(0, 0, 0, 0, 0, 1)
        end
    end
end

function onEventFinish(player, csid, option)
end

function onGameHour(zone)
    local hour = VanadielHour()

    if hour < 7 or hour >= 17 then
        for mob = ID.mob.SKELETON_SCUFFLER, ID.mob.SKELETON_SCUFFLER + 2 do
            local respawn = GetMobByID(mob):getLocalVar("respawn")
            if not GetMobByID(mob):isSpawned() and os.time() > respawn then
                SpawnMob(mob)
            end
        end
        for mob = ID.mob.BLEST_BONES, ID.mob.BLEST_BONES + 2 do
            local respawn = GetMobByID(mob):getLocalVar("respawn")
            if not GetMobByID(mob):isSpawned() and os.time() > respawn then
                SpawnMob(mob)
            end
        end
        for mob = ID.mob.HOLEY_HORROR, ID.mob.HOLEY_HORROR + 2 do
            local respawn = GetMobByID(mob):getLocalVar("respawn")
            if not GetMobByID(mob):isSpawned() and os.time() > respawn then
                SpawnMob(mob)
            end
        end
    end
end