-----------------------------------
--
-- Zone: Ship_bound_for_Mhaura_Pirates (228)
--
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura_Pirates/IDs")
require("scripts/globals/conquest")
require("scripts/globals/zone")
require("scripts/globals/pirates")
require("scripts/globals/sea_creatures")
-----------------------------------
function onInitialize(zone)

    tpz.pirates.init(ID)

    zone:addListener("TRANSPORTZONE_END", "MHAURA_PIRATES_TRANSPORTZONE_END", function(transportZone)
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end
        tpz.sea_creatures.despawn(ID)
    end)

    zone:addListener("TRANSPORTZONE_START", "MHAURA_PIRATES_TRANSPORTZONE_START", function(transportZone)
        tpz.pirates.start(ID)
        tpz.sea_creatures.checkSpawns(ID, 5, 1) -- 5 percent on init
    end)

    zone:addListener("TRANSPORTZONE_UPDATE", "MHAURA_PIRATES_TRANSPORTZONE_UPDATE", function(transportZone, tripTime)
        tpz.pirates.update(ID, transportZone, tripTime)
        tpz.sea_creatures.checkSpawns(ID, 1, 2) -- 1 percent per vana minute, 2 total mobs
    end)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(-2, 2) + 0.150
        player:setPos(position, -2.100, 3.250, 64)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onGameHour(zone)
    local hour = VanadielHour()
    if hour >= 20 or hour < 4 then
        if math.random() < 0.20 and not GetMobByID(ID.mob.PHANTOM):isSpawned() then
            GetMobByID(ID.mob.PHANTOM):spawn()
        end
    elseif GetMobByID(ID.mob.PHANTOM):isSpawned() then
        DespawnMob(ID.mob.PHANTOM)
    end
end

function onTransportEvent(player, transport)
    player:startEvent(512)
end
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 512 then
        player:setPos(0, 0, 0, 0, tpz.zone.MHAURA)
    end
end
