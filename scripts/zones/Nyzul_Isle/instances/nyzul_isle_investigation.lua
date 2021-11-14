--------------------------------------------------
--
-- Nyzul Isle Investigation
--
--------------------------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/nyzul_isle_data")
--------------------------------------------------


function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    local mobsToSpawn = {}
    local floorMobs = tpz.nyzul_isle_data.mobsByType["AQUANS"]
    for key, value in pairs(floorMobs) do
        for nestedKey, nestedValue in pairs(value) do
            table.insert(mobsToSpawn, nestedValue)
            local mob = GetMobByID(nestedValue, instance)
            mob:setSpawn(-11, -4, -11)
            --SpawnMob(nestedValue, instance)
        end
    end

    printf("mobs to spawn ")
    for key, value in pairs(mobsToSpawn) do
        printf("mobs to spawn %d", value)
    end



        local mobsToSpawn = nil
        mobsToSpawn = {}
        printf("building up floor mobs\n")
        local floorMobs = tpz.nyzul_isle_data.mobsByType["LIZARDS"]
        for key, value in pairs(floorMobs) do
            for nestedKey, nestedValue in pairs(value) do
                table.insert(mobsToSpawn, nestedValue)
            end
        end
        local specifiedEnmeies = tpz.nyzul_isle_data.mobsByType["QIQIRN"]
        printf("building up specified enemeies\n")
        for key, value in pairs(specifiedEnmeies) do
            for nestedKey, nestedValue in pairs(value) do
                table.insert(mobsToSpawn, nestedValue)
            end
        end
        local possibleNMs = tpz.nyzul_isle_data.mobsByType["NMS_21_39"]["NotoriusMonsters"]
        local nmIndex = math.random(#possibleNMs)
        local nmID1 = possibleNMs[nmIndex]
        table.insert(mobsToSpawn, nmID1)

        local mobSpawnPoints = {}
        local rooms = tpz.nyzul_isle_data.northEastFloorLayouts["FLOOR_NE_1"]["Rooms"]
   
        for key, value in pairs(rooms) do
            local spawnpoints = tpz.nyzul_isle_data.northEastRoomConfigurations[value]["MobSpawnPoints"]
            for subkey, subvalue in pairs(spawnpoints) do
                table.insert(mobSpawnPoints, subvalue)
            end
        end

        local mob
        for key, value in pairs(mobsToSpawn) do
            mob = GetMobByID(value, instance)

            printf("mob id %d", value)
            spawnpointIndex = math.random(#mobSpawnPoints)
            spawnpoint = mobSpawnPoints[spawnpointIndex]
            mob:setSpawn(spawnpoint["x"], spawnpoint["y"], spawnpoint["z"])
            SpawnMob(value, instance)
            table.remove(mobSpawnPoints, spawnpointIndex)
        end


end

function onInstanceTimeUpdate(instance, elapsed)
    local once = false

    local tempmob = GetMobByID(17092910, instance)
    tempmob:setSpawn(500, 0, 60)
    --SpawnMob(17092910, instance)

    printf("onInstanceTimeUpdate \n")
end

function onInstanceFailure(instance)
    printf("onInstanceFailure\n")
end

function onInstanceProgressUpdate(instance, progress)
    printf("onInstanceProgressUpdate\n")
end

function onInstanceStageChange(instance)
    printf("onInstanceStageChange\n")
end

function onInstanceComplete(instance)
    printf("onInstanceComplete\n")
end

function onEventUpdate(player, csid, option)
    printf("onEventUpdate CSID %u OPTION %u\n", csid, option)
    --player:setPos(-11, -4, -20, 5)
end

function onEventFinish(player, csid, option)
    printf("onEventFinish CSID %u OPTION %u\n", csid, option)
end