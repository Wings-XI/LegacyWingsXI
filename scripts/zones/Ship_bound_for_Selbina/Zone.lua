-----------------------------------
--
-- Zone: Ship_bound_for_Selbina (220)
--
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Selbina/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/sea_creatures")
-----------------------------------
function onInitialize(zone)
    zone:addListener("TRANSPORTZONE_END", "SELBINA_TRANSPORTZONE_END", function(transportZone)
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end
        if GetMobByID(ID.mob.ENAGAKURE):isSpawned() then
            DespawnMob(ID.mob.ENAGAKURE)
        end
        if GetMobByID(ID.mob.SEA_HORROR):isSpawned() then
            DespawnMob(ID.mob.SEA_HORROR)
        end
        tpz.sea_creatures.despawn(ID)
    end)

    zone:addListener("TRANSPORTZONE_START", "SELBINA_TRANSPORTZONE_START", function(transportZone)
        if GetMobByID(ID.mob.SEA_HORROR):isSpawned() then -- make sure we dont have horror from previous or docked zone
            DespawnMob(ID.mob.SEA_HORROR)
        end
        tpz.sea_creatures.checkSpawns(ID, 5, 1) -- 5 percent on init
    end)

    zone:addListener("TRANSPORTZONE_UPDATE", "SELBINA_TRANSPORTZONE_UPDATE", function(transportZone, tripTime)
        tpz.sea_creatures.checkSpawns(ID, 1, 2) -- 1 percent per vana minute, 2 total mobs
    end)
end

function onZoneIn(player, prevZone)

    local cs = -1

    if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
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
        -- Check for Enagakure
        local players = zone:getPlayers()
        for _, player in pairs(players) do
            if player:hasKeyItem(tpz.ki.SEANCE_STAFF)
                and player:getCharVar("Enagakure_Killed") == 0
                and not GetMobByID(ID.mob.ENAGAKURE):isSpawned() then
                    GetMobByID(ID.mob.ENAGAKURE):spawn()
            end
        end
        if math.random() < 0.20 and not GetMobByID(ID.mob.PHANTOM):isSpawned() then
            GetMobByID(ID.mob.PHANTOM):spawn()
        end
    else
        if GetMobByID(ID.mob.PHANTOM):isSpawned() then
            DespawnMob(ID.mob.PHANTOM)
        end
        if GetMobByID(ID.mob.ENAGAKURE):isSpawned() then
            DespawnMob(ID.mob.ENAGAKURE)
        end
    end

    local mob = GetMobByID(ID.mob.SEA_HORROR)
    -- 3% chance per game hour (if not spawned, and min repop time)
    if math.random(0, 100) < 3 and not mob:isSpawned() and os.time() > mob:getLocalVar("respawnTime") then
        mob:spawn()
    end
end

function onTransportEvent(player, transport)
    player:startEvent(255)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 255) then
        player:setPos(0, 0, 0, 0, 248)
    end
end
