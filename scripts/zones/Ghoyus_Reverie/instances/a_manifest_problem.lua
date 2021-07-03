-----------------------------------
--
-- A Manifest Problem
-- WotG Windy Mission Quest - 04
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/msg")
local ID = require("scripts/zones/Ghoyus_Reverie/IDs")
-----------------------------------

local originalSpawns = {
    [17305647] = {x = -98.596,  z = -0.003, y = 259.135},
    [17305648] = {x = -178.818, z = 19.781, y = 289.330},
    [17305649] = {x = -186.184, z = 19.489, y = 304.580},
    [17305650] = {x = -185.852, z = 19.771, y = 296.871},
    [17305651] = {x = -168.025, z = 19.885, y = 299.214},
    [17305652] = {x = -101.171, z = -0.443, y = 268.997},
    [17305653] = {x = -128.054, z = 11.260, y = 296.860},
    [17305654] = {x = -184.020, z = 19.937, y = 294.963},
    [17305655] = {x = -184.384, z = 19.877, y = 294.881},
    [17305656] = {x = -181.758, z = 19.694, y = 290.683},
    [17305657] = {x = -99.618, z = -0.327, y = 267.136},
    [17305658] = {x = -185.527, z = 19.446, y = 300.941},
    [17305659] = {x = -179.182, z = 19.793, y = 281.985},
    [17305660] = {x = -185.960, z = 19.698, y = 294.488},
    [17305661] = {x = -104.173, z = 4.087, y = 291.537},
    [17305662] = {x = -141.111, z = -0.420, y = 163.878}
}

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    cleanUpInstance(instance)
    for mobID = ID.mob.MANIFEST_PROBLEM_START, ID.mob.MANIFEST_PROBLEM_END, 1
    do
        SpawnMob(mobID, instance)
    end
end

function onInstanceTimeUpdate(instance, elapsed)
    if instance:getStage()==0 or instance:getStage()==1 then
        -- During stage 0 and 1 - respawn mobs infinitely
        for mobID = ID.mob.MANIFEST_PROBLEM_START, ID.mob.MANIFEST_PROBLEM_END, 1
        do
            local mob = GetMobByID(mobID, instance)
            if not mob:isSpawned() then
                SpawnMob(mobID, instance)
                local offset = math.random(-5, 5)
                if not mob:isEngaged() then
                    mob:pathTo(-137.27+offset, 1.0, 201.26+offset)
                end
                mob:setSpawn(-137.27+offset, 1.0, 201.26+offset)
            end
        end
    elseif instance:getStage(3) then
        -- track all mobs alive for win condition
        local mobs = instance:getMobs()
        local win = true
        for i, mob in pairs(mobs) do
            if mob:isSpawned() then
                win = false
            end
        end
        
        if win then
            instance:complete()
        end
    end
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    -- intentionally no localVar status update on failure
    cleanUpInstance(instance)

    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:startEvent(10001)
    end
end

function onInstanceProgressUpdate(instance, progress)
    if progress > 45 and instance:getStage() == 1 then
        instance:setStage(2) -- Spawn the boss, stop respawn of other yagudos
    end
end

function onInstanceStageChange(instance, stage)
    if stage == 1 then
        pathAllMobsToCenter(instance, false)
    elseif stage == 2 then
        -- Attempt to respawn all yagudo who may not be currently spawned along with the boss
        local mobs = instance:getMobs()
        for i, mob in pairs(mobs) do
            if not mob:isSpawned() then
                SpawnMob(mob:getID(), instance)
            end
        end
        pathAllMobsToCenter(instance, true)
    end
    
end

function onInstanceComplete(instance)
    cleanUpInstance(instance)

    local chars = instance:getChars()

    for i, player in pairs(chars) do
        if (player:getCharVar("ManifestProblem") == 4) then
            player:setCharVar("ManifestProblem", 5)
            player:startEvent(10000, 300, -750, 205115, 2349) -- params dont seem to have an effect, but these are from a capture
        else
            player:startEvent(10001) -- player who dont complete the mission are put back by the colorful door
        end
    end
end

function onRegionEnter(player, region)
    local regionId = region:GetRegionID()

    local instance = player:getInstance()
    if instance ~= nil and instance:getStage()==0 then
        instance:setStage(1) -- this triggeres the mobs to be active and begin moving in the instance
    end
    
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function pathAllMobsToCenter(instance, moveLaaYaku)
    local mobs = instance:getMobs()

    for i, mob in pairs(mobs) do
        local offset = math.random(-5, 5)
        if mob:getID() ~= ID.mob.LAA_YAKU_THE_AUSTERE or moveLaaYaku then
            if not mob:isEngaged() then
                mob:pathTo(-137.27+offset, 1.0, 201.26+offset)
            end
            mob:setSpawn(-137.27+offset, 1.0, 201.26+offset)
        end
    end
end

function resetMobSpawns(instance)
    local mobs = instance:getMobs()
    for i, mob in pairs(mobs) do
        mobID = mob:getID()
        mob:setSpawn(originalSpawns[mobID].x, originalSpawns[mobID].z, originalSpawns[mobID].y)
    end
end

function cleanUpInstance(instance)
    resetMobSpawns(instance)
    instance:setStage(0)
    instance:setProgress(0)
end

