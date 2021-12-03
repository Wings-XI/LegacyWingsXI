---------------------------------------------------
--
-- Logic for Nyzul Isle
--
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/instance")
require("scripts/globals/npc_util")
require("scripts/globals/nyzul_isle_data")
---------------------------------------------------
tpz = tpz or {}
tpz.nyzul_isle = tpz.nyzul_isle or {}

--------------------------------------------------------
-- Constants for configuring randomness
--------------------------------------------------------
local FREE_FLOOR_CHANCE = 5 -- 5% chance of a free floor
local GEAR_SUB_OBJECTIVE_CHANCE = 5 -- 5% chance of having a gear related sub objective
local NM_1_CHANCE = 75 -- chance to see 1 NM
local NM_2_CHANCE = 50 -- chance to see 2 NMs
local NM_3_CHANCE = 25 -- chance to see 3 NMs

------------------------------------------------------------------------------------------
-- Generates the Nyzul Isle Floor
-- Returns: Rune of Transfer spawnpoint, List of Mobs
--          The list of mobs required to be killed for objective clear (can be empty)
------------------------------------------------------------------------------------------
function generateFloor(floorNumber, instance)
    local runeOfTransferSpawnPoint
    local previousFloorInfo = {
        objective = instance:getLocalVar("Nyzul_Objective"),
        subObjective = instance:getLocalVar("Nyzul_SubObjective"),
        previousMap = instance:getLocalVar("Nyzul_Map"),
        previousMobType = instance:getLocalVar("Nyzul_MobType")
    }
    
    -- clean up the previous floor that players are leaving
    cleanUpPreviousFloor(instance)

    -- if this is a boss floor (20, 40, 60, 80, 100, "120", "140", etc) generate a boss floor
    if (floorNumber % 20 == 0) then
        runeOfTransferSpawnPoint, bossID = generateBossFloor(floorNumber, instance)
        return runeOfTransferSpawnPoint, {bossID} 
    end

    -- randomly generate a free floor if this is not the first floor in a run
    if (math.Random(1, 100) < FREE_FLOOR_CHANCE and previousFloorInfo ~= nil) then
        runeOfTransferSpawnPoint = generateFreeFloor(floorNumber, instance)
        return runeOfTransferSpawnPoint, {} -- no mobs on free floor
    end

    --otherwise generate a standard floor
    runeOfTransferSpawnPoint, objectiveMobs = generateStandardFloor(floorNumber, instance, previousFloorInfo)
    return runeOfTransferSpawnPoint, objectiveMobs
end

-------------------------------------------------------
-- Performs all work for generating a Free Floor
--
-------------------------------------------------------
function generateFreeFloor(floorNumber, instance)
    -- set objectives
    instance:setLocalVar("Nyzul_Objective", 0) -- FREE_FLOOR
    instance:setLocalVar("Nyzul_SubObjective", 0) -- No gears on free floors
    -- pick a floor
    -- get rune of transfer
    local activeRuneOfTransfer = selectRuneOfTransfer(floorNumber, instance)
    -- spawn runeOfTransfer
    -- set runeOfTransferAnimation to lit
    -- spawn 5-10 Armoury_Crates with temp items using mob spawn mechanic
    return runeOfTransferSpawnPoint
end

-------------------------------------------------------
-- Performs all work for generating a Boss Floor
-------------------------------------------------------
function generateBossFloor(floorNumber, instance)
    -- set objectives
    instance:setLocalVar("Nyzul_Objective", 1) -- ELIMINATE_ENEMY_LEADER
    instance:setLocalVar("Nyzul_SubObjective", 0) -- No gears on boss floors
    -- randomize a boss floor
    local bossFloorKey = tpz.nyzul_isle_data.bossFloorTableKeys[math.random(#tpz.nyzul_isle_data.bossFloorTableKeys)]
    local bossFloor = tpz.nyzul_isle_data.bossFloorLayouts[bossFloorKey]

    -- update the current map
    if (bossFloorKey == 1) then
        -- only one boss floor is on the SOUTH map
        instance:setLocalVar("Nyzul_Map", 2)
    else
        -- all other boss floors are on the SOUTH_WEST map
        instance:setLocalVar("Nyzul_Map", 1)
    end

    -- get and setup entities that alternate per floor
    local runeOfTransferSpawnPoint = bossFloor.RuneOfTransferSpawnPoint
    local activeRuneOfTransfer = selectRuneOfTransfer(floorNumber, instance, runeOfTransferSpawnPoint)
    local archaicRampartID = selectArchaicRampartID(floorNumber)

    -- Randomly pick a boss from BOSSES_20_40 or BOSSES_60_100 depending on floor
    local possibleNMs
    if (floorNumber == 20 or floorNumber == 40) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.BOSSES_20_40.Bosses
    else
        possibleNMs = tpz.nyzul_isle_data.mobsByType.BOSSES_60_100.Bosses
    end
    local bossID = possibleNMs[math.random(#possibleNMs)]

    -- randomize a boss spawn point
    local bossSpawnPointIndex = math.random(#bossFloor.BossSpawnPoints)
    local bossSpawnPoint = bossFloor.BossSpawnPoints[bossSpawnPointIndex]

    -- randomize an archaicRampart spawn, excluding the boss spawn point
    local remainingSpawnPoints = {}
    for key, value in pairs(bossFloor.RampartSpawnPoints) do
        table.insert(remainingSpawnPoints, value)
    end
    table.remove(remainingSpawnPoints, bossSpawnPointIndex)
    local archaicRampartSpawnPoint = remainingSpawnPoints[math.random(#remainingSpawnPoints)]

    -- Spawn the mobs
    setSpawnPointAndSpawnMob(bossID, bossSpawnPoint, instance)
    setSpawnPointAndSpawnMob(archaicRampartID, archaicRampartSpawnPoint, instance)

    -- 
    if (floorNumber == 100) then
        setBossWeaponDrop(bossID, instance)
    end

    return runeOfTransferSpawnPoint, bossID
end

-------------------------------------------------------
-- Performs all work for generating a Standard Floor
-------------------------------------------------------
function generateStandardFloor(floorNumber, instance, previousFloorInfo) 
   local objective = selectObjective(instance, previousFloorInfo.objective)
   local subObjective = selectSubObjective(instance, previousFloorInfo.subObjective)
   local selectedFloorLayout = selectFloorLayout(instance, previousFloorInfo.previousMap)
   setDoorAnimations(instance, selectedFloorLayout.DoorsToOpen, true, false)
   local objectiveMobs = generateAndSpawnRequiredMobs(instance, floorNumber, objective, subObjective, selectedFloorLayout, previousFloorInfo.previousMobType)

   generateAndSpawnRequiredLamps(instance, objective, selectedFloorLayout)

   return selectedFloorLayout.runeOfTransferSpawnPoint, objectiveMobs
end

------------------------------------------------------------------
-- Selects an objective for the standard floor and sets local var
------------------------------------------------------------------
function selectObjective(instance, previousObjective)
    -- select an objective excluding the previousObjective
    local objectiveKey = math.random(#tpz.nyzul_isle_data.objectiveType)
    if (previousObjective) then
        while objectiveKey == previousObjective do
            objectiveKey = math.random(#tpz.nyzul_isle_data.objectiveType)
        end
    end

    instance:setLocalVar("Nyzul_Objective", objectiveKey)
    return tpz.nyzul_isle_data.objectiveType[objectiveKey]
end

--------------------------------------------------------------------
-- Selects a sub objective for the standard floor and sets local var
--------------------------------------------------------------------
function selectSubObjective(instance, previousSubObjective)
    if (previousSubObjective or (math.random(100) > GEAR_SUB_OBJECTIVE_CHANCE)) then
        -- the previous floor had gears or the randomizing chose no gears
        instance:setLocalVar("Nyzul_SubObjective", 0)
        return "None"
    end

    local subObjectiveKey = math.random(#tpz.nyzul_isle_data.subObjectiveType)
    instance:setLocalVar("Nyzul_SubObjective", subObjectiveKey)
    return tpz.nyzul_isle_data.subObjectiveType[subObjectiveKey]
end

--------------------------------------------------------------------
-- Selects a floor layout for the standard floor and sets local var
--------------------------------------------------------------------
function selectFloorLayout(instance, previousMap)
    -- select a map, excluding the previousMap
    local selectedMap = math.random(1,6)
    if (previousMap) then
        while selectedMap == previousMap do
            selectedMap = math.random(1,6)
        end
    end
    instance:setLocalVar("Nyzul_Map", selectedMap)

    local selectedFloorLayout
    -- choose a floor from the map
    if (selectedMap == 1) then
        selectedFloorLayout = tpz.nyzul_isle_data.northEastFloorLayouts[tpz.nyzul_isle_data.northEastFloorTableKeys[math.random(#tpz.nyzul_isle_data.northEastFloorTableKeys)]]
    elseif (selectedMap == 2) then
        selectedFloorLayout = tpz.nyzul_isle_data.eastFloorLayouts[tpz.nyzul_isle_data.eastFloorTableKeys[math.random(#tpz.nyzul_isle_data.eastFloorTableKeys)]]
    elseif (selectedMap == 3) then
        selectedFloorLayout = tpz.nyzul_isle_data.centralFloorLayouts[tpz.nyzul_isle_data.centralFloorTableKeys[math.random(#tpz.nyzul_isle_data.centralFloorTableKeys)]]
    elseif (selectedMap == 4) then
        selectedFloorLayout = tpz.nyzul_isle_data.southEastFloorLayouts[tpz.nyzul_isle_data.southEastFloorTableKeys[math.random(#tpz.nyzul_isle_data.southEastFloorTableKeys)]]
    elseif (selectedMap == 5) then
        selectedFloorLayout = tpz.nyzul_isle_data.southFloorLayouts[tpz.nyzul_isle_data.southFloorTableKeys[math.random(#tpz.nyzul_isle_data.southFloorTableKeys)]]
    else
        selectedFloorLayout = tpz.nyzul_isle_data.southWestFloorLayouts[tpz.nyzul_isle_data.southWestFloorTableKeys[math.random(#tpz.nyzul_isle_data.southWestFloorTableKeys)]]
    end

    return selectedFloorLayout
end

--------------------------------------------------------------------
--  Generates and spawns all of the mobs required for the floor
--  Returns a list of mobs required to kill for the objective clear
--------------------------------------------------------------------
function generateAndSpawnRequiredMobs(instance, floorNumber, objective, subObjective, selectedFloorLayout, previousMobType)
    local objectiveMobs = {}
    local mobsToSpawn = {}

    -- we always need base floor mobs
    local selectedFloorMobs = selectFloorMobs(previousMobType)
    -- we always need to check for NMs
    local selectedNotorusMonsters = selectNotoriusMonsters(floorNumber)

    mobsToSpawn = addTableListsTogether(selectedFloorMobs, selectedNotorusMonsters)

    -- get the archaic rampart
    local archaicRampartID = selectArchaicRampartID(floorNumber)
    table.insert(mobsToSpawn, archaicRampartID)

    if (objective == "ELIMINATE_ALL_ENEMIES") then
        if (math.random(1, 2) == 2) then
            -- surprise DAHAK!
            table.insert(mobsToSpawn, tpz.nyzul_isle_data.mobsByType.DAHAK.Dahak[1])
        end

        -- just does a deep copy
        objectiveMobs = addTableListsTogether(mobsToSpawn, {})
    elseif (objective == "ELIMINATE_ENEMY_LEADER") then
        -- randomize leader
        local leaderID = tpz.nyzul_isle_data.mobsByType.LEADERS.Leaders[math.random(#tpz.nyzul_isle_data.mobsByType.LEADERS.Leaders)]
        table.insert(objectiveMobs, leaderID)
        table.insert(mobsToSpawn, leaderID)
    elseif (objective == "ELIMINATE_SPECIFIED_ENEMY") then
        -- randomize the mob to be the specified enemy
        -- set mob as an NM, and store a local var to clean up later
        local specifiedEnemyID = selectedFloorMobs[math.random(#selectedFloorMobs)]
        table.insert(objectiveMobs, specifiedEnemyID)
        local specifiedEnemy = GetMobByID(specifiedEnemyID, instance)
        instance:setLocalVar("Nyzul_Specified_Enemy", specifiedEnemyID)
        specifiedEnemy:setNM(true)
    elseif (objective == "ELIMINATE_SPECIFIED_ENEMIES") then
        -- randomizes the selection
        local specifiedEnemies = selectSpecifiedEnemies(instance)
        objectiveMobs = specifiedEnemies
        mobsToSpawn = addTableListsTogether(mobsToSpawn, specifiedEnemies)
    end

    if (subObjective == "DO_NOT_DEFEAT_GEARS" or subObjective == "AVOID_DECTECTION_BY_GEARS") then
        -- Add some gears -- gears are never part of the objective
        local selectedGearMobs = selectGearMobs(instance, subObjective)
        mobsToSpawn = addTableListsTogether(mobsToSpawn, selectedGearMobs)
    end

    spawnMobsForFloor(instance, mobsToSpawn, selectedFloorLayout.Rooms)

    return objectiveMobs
end

-----------------------------------------------------------------
--  Selects the floor mobs - excluding the previous floor mobs
--  Returns a list of mobs
-----------------------------------------------------------------
function selectFloorMobs(previousMobType)
    local FIRST_FLOOR_MOB_INDEX = 1
    local LAST_FLOOR_MOB_INDEX = 16

    local floorMobKey = math.random(FIRST_FLOOR_MOB_INDEX, LAST_FLOOR_MOB_INDEX)
    if (previousMobType) then
        while floorMobKey == previousMobType do
            floorMobKey = math.random(FIRST_FLOOR_MOB_INDEX, LAST_FLOOR_MOB_INDEX)
        end
    end

    instance:setLocalVar("Nyzul_MobType", floorMobKey)

    local floorMobLists =  tpz.nyzul_isle_data.mobsByType[tpz.nyzul_isle_data.mobType[floorMobKey]]

    return selectRandomizedAmountOfMobs(floorMobLists)
end

----------------------------------------------
-- Selects NMs to spawn based on floor
----------------------------------------------
function selectNotoriusMonsters(floorNumber)
    local notriousMonsters = {}
    local nm1
    local nm2
    local nm3
    local possibleNMs

    -- determine the possible NM set
    if (floorNumber < 20) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_01_19
    elseif (floorNumber < 40) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_21_39
    elseif (floorNumber < 60) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_41_59
    elseif (floorNumber < 80) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_61_79
    elseif (floorNumber < 100) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_81_99
    elseif (floorNumber < 120) then
        -- while there are only 100 floors, depending on how the instance tracks this - we need to handle 101 (post floor 100 win)
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_01_19
    elseif (floorNumber < 140) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_21_39
    else
        possibleNMs = tpz.nyzul_isle_data.mobsByType.NMS_41_59
    end

    local randomRoll = math.random(1, 100)

    if (randomRoll < NM_1_CHANCE ) then
        nm1 = possibleNMs[math.random(#possibleNMs)]
        table.insert(notriousMonsters, nm1)
    end

    if (randomRoll < NM_2_CHANCE ) then
        nm2 = possibleNMs[math.random(#possibleNMs)]
        while (nm2 == nm1) do
            nm2 = possibleNMs[math.random(#possibleNMs)]
        end
        table.insert(notriousMonsters, nm2)
    end

    -- this is about the limit of using this method for random selection without replacement
    -- there are 18 NMs per grouping so selecting 3 has a reasonable chance of collision 
    if (randomRoll < NM_3_CHANCE ) then
        nm3 = possibleNMs[math.random(#possibleNMs)]
        while (nm3 == nm1 or nm3 == nm2) do
            nm3 = possibleNMs[math.random(#possibleNMs)]
        end
        table.insert(notriousMonsters, nm3)
    end

    return notriousMonsters
end

------------------------------------------------------------------
--  Selects a set of specified enemeies and sets their NM flags
------------------------------------------------------------------
function selectSpecifiedEnemies(instance)
    local FIRST_SPECIFIC_MOB_INDEX = 19
    local LAST_SPECIFIC_MOB_INDEX = 24

    -- consider not selecting soulflayers when the floor mobs are demons - Psycheflayers are in both groupings
    local specificEnemiesMobKey = math.random(FIRST_SPECIFIC_MOB_INDEX, LAST_SPECIFIC_MOB_INDEX)
    local specificEnemiesMobLists =  tpz.nyzul_isle_data.mobsByType[tpz.nyzul_isle_data.mobType[specificEnemiesMobKey]]

    local selectedSpecificEnemiesMobList = selectRandomizedAmountOfMobs(specificEnemiesMobLists)
    -- set all as NM, as these mobs use shared pools
    for key, value in pairs(selectedSpecificEnemiesMobList) do
        mob = GetMobByID(value, instance)
        mob:setNM(true)
    end

    return selectedSpecificEnemiesMobList
end

--------------------------------------------------------------
-- Selects gear mobs and sets local vars based on subObjective
--------------------------------------------------------------
function selectGearMobs(instance, subObjective)
    local gearLists
    if (math.random(1,2) == 1) then
        gearLists = tpz.nyzul_isle_data.mobType.GEARS.Archaic_Gear
    else
        gearLists = tpz.nyzul_isle_data.mobType.GEARS.Archaic_Gears
    end

    local selectedGearMobList = selectRandomizedAmountOfMobs(gearLists)

    -- default to Dont Aggro
    local subObjectiveLocalVar = 2
    if (subObjective == "DO_NOT_DEFEAT_GEARS") then
        subObjectiveLocalVar = 1
    end

    for key, value in pairs(selectedSpecificEnemiesMobList) do
        mob = GetMobByID(value, instance)
        mob:setLocalVar("Nyzul_GearObjective", subObjectiveLocalVar)
    end

    return selectedGearMobList

end

------------------------------------------------------------------
--  Selects a randomized amount of mobs from the given collections
------------------------------------------------------------------
function selectRandomizedAmountOfMobs(mobsByType)
    local selectedMobs = {}
    for key, value in pairs(mobsByType) do
        -- ToDo: Can add a constant or config to push this randomization up or down
        -- Currently does 1/2 of the mobs as a minimum per grouping
        randomValue = math.random(#value/2, #value)
        for i = 1, randomValue do
            table.insert(selectedMobs, value[i])
        end
    end

    return selectedMobs
end

----------------------------------------------------------------------------
-- Sets Door animations
-- Params:
--      doorsTable - table of doors to open or close
--      openDoors - true to open doors, false to close
--      allDoors - if true, will take the action (open/close) on ALL doors
--      instance - the instance the doors are in
---------------------------------------------------------------------------
function setDoorAnimations(instance, doorsTable, openDoors, allDoors)
    local firstDoorID = 17093353
    local lastDoorID = 17093416
    local npc
    
    local animationID = tpz.animation.CLOSE_DOOR
    if (openDoors) then
        animationID = tpz.animation.OPEN_DOOR
    end

    if (allDoors) then
        for i = firstDoorID, lastDoorID do
            npc = GetNPCByID(i, instance)
            npc:setAnimation(animationId)
        end
    else
        for key, value in pairs(doorsTable) do
            npc = GetNPCByID(value, instance)
            npc:setAnimation(animationId)
        end
    end

end

----------------------------------------------------------------------
-- Find spawn points and spawn all mobs
----------------------------------------------------------------------
function spawnMobsForFloor(instance, mobsToSpawn, rooms)
    local spawnPoints = {}
    for key, value in pairs(rooms) do
        -- for each room get the mob spawn points and add to the collection
        for nestedKey, nestedValue in pairs(tpz.nyzul_isle_data.roomConfigurations[value].MobSpawnPoints) do
        table.insert(spawnPoints, nestedValue)
        end
    end

    -- set and spawn all mobs
    for key, mobID in pairs(mobsToSpawn) do
        if (#spawnPoints == 0) then
            printf("Attempted to spawn a mob but no more spawn points are available - mobID %d", mobID)
        end
        index = math.random(#spawnPoints)
        spawnPoint = spawnPoints[index]
        setSpawnPointAndSpawnMob(mobID, spawnPoint, instance)
        table.remove(spawnPoints, index)
    end
end

-----------------------------------------------------------------------
--  Generates required Lamps triggers spawn
-----------------------------------------------------------------------
function generateAndSpawnRequiredLamps(instance, objective, selectedFloorLayout)
    local lampsToSpawn = {}
    -- default to 5
    local lampObjective = 5
    local numberOfLamps = math.random(3, 5)
    
    if (objective == "ACTIVATE_ALL_LAMPS_CERTIFICATION") then
        numberOfLamps = 1
        lampObjective = 5 
    elseif (objective == "ACTIVATE_ALL_LAMPS_SAME_TIME") then
        lampObjective = 6
    elseif (objective == "ACTIVATE_ALL_LAMPS_ORDERED") then
        lampObjective = 7
    end

    -- generate lamps to spawn
    for i = 1, numberOfLamps do
        lampID = tpz.nyzul_isle_data.npcLists.Lamps[i]
        table.insert(lampsToSpawn, lampID)
    end

    spawnLampsForFloor(instance, lampsToSpawn, selectedFloorLayout.rooms, lampObjective)
    instance:setLocalVar("Nyzul_LampsToLight", numberOfLamps)
end

-------------------------------------------------------------------------
--  Spawns and sets local vars for Lamps
-------------------------------------------------------------------------
function spawnLampsForFloor(instance, lampsToSpawn, rooms, lampObjective)
    local spawnPoints = {}

    -- Ordered Lamps
    if (lampObjective == 7) then
        local lampOrder = {}
        local numberOfLamps = #lampsToSpawn
        for i = 1, numberOfLamps do
            table.insert(lampOrder, i)
        end
    end

    -- get one lamp spawn point per room
    for key, value in pairs(rooms) do
        -- for each room select 1 spawn point from the available lamp spawn points
        table.insert(spawnPoints, tpz.nyzul_isle_data.roomConfigurations[value].LampSpawnPoints[math.random(#tpz.nyzul_isle_data.roomConfigurations[value].LampSpawnPoints)])
    end

    -- randomize spawn points, spawn lamps, and set local vars
    for key, lampID in pairs(lampsToSpawn) do
        if (#spawnPoints == 0) then
            printf("Attempted to spawn a lamp but no more spawn points are available - lampID %d", lampID)
        end
        lamp = GetNPCByID(lampID, instance)
        lamp:setLocalVar("Nyzul_LampObjective", lampObjective)

        -- Ordered lamps
        if (lampObjective == 7) then
            random = math.random(#lampOrder)
            lamp:setLocalVart("Nyzul_LampOrder", lampOrder[random])
            table.remove(lampOrder, random)
        end

        index = math.random(#spawnPoints)
        spawnPoint = spawnPoints[index]
        -- using a delay of 100 as the default delay on queueMove is 3000 (3 seconds)
        npcUtil.queueMove(lamp, spawnPoint, 100)
        lamp:setStatus(tpz.status.NORMAL)
        table.remove(spawnPoints, index)
    end

end

-------------------------------------------------------
-- Selects, positions, and spawns the Rune of Transfer
-------------------------------------------------------
function selectRuneOfTransfer(floorNumber, instance, runeOfTransferSpawnPoint)
    local runeOfTransfer

    -- choose the alternating runeOfTransfer
    if ((floorNumber % 2) == 0) then -- even floor
        runeOfTransfer = GetNPCByID(17093330, instance)
    else
        runeOfTransfer = GetNPCByID(17093331, instance)
    end

    -- move the runeOfTransfer to the correct location
    -- using a delay of 100 as the default delay on queueMove is 3000 (3 seconds)
    npcUtil.queueMove(runeOfTransfer, runeOfTransferSpawnPoint, 100)

    -- make the rune of transfer visible
    runeOfTransfer:setStatus(tpz.status.NORMAL)

    return runeOfTransfer
end

-------------------------------------------------------
-- Selects the archaicRampart for the floor
-------------------------------------------------------
function selectArchaicRampartID(floorNumber)
    local archaicRampart

    if ((floorNumber % 2) == 0) then -- even floor
        archaicRampart = 17092629
    else
        archaicRampart = 17092630
    end

    return archaicRampart
end

-----------------------------------------------------------------------------------
-- Given mobID, a spawnPoint, and the instance - sets spawnpoint and spawns the mob
-----------------------------------------------------------------------------------
function setSpawnPointAndSpawnMob(mobID, spawnPoint, instance)
    local mob = GetMobByID(mobID, instance)
    mob:setSpawn(spawnPoint.x, spawnPoint.y, spawnPoint.z)
    SpawnMob(mobID, instance)
end

----------------------------------------------------------------------------------------------
--  Checks players in instance and forces a drop for the job of the player who started the run
--  Only applied to floor 100 bosses
----------------------------------------------------------------------------------------------
function setBossWeaponDrop(bossID, instance)
    local job = instance:getLocalVar("Nyzul_DiscUserJob")

    -- tpz.job starts at 1
    if (job) then
        local boss = GetMobByID(bossID, instance)
        boss:setLocalVar("Nyzul_ForceWeaponDrop", tpz.nyzul_isle_data.jobToVigilWeaponMap[job])
    end
end

------------------------------------------------
-- Adds all mobs in two tables (lists) together
------------------------------------------------
function addTableListsTogether(table1, table2)
    local returnTable = {}

    for key, value in pairs(table1) do
        table.insert(returnTable, value)
    end

    for key, value in pairs(table2) do
        table.insert(returnTable, value)
    end

    return returnTable
end

--------------------------------------------------------------------
-- Cleans up the previous floor as players teleport to the new floor
--------------------------------------------------------------------
function cleanUpPreviousFloor(instance)
    -- Hide lamps
    -- Hide runeOfTransfers
        --runeOfTransfer:setStatus(tpz.status.DISAPPEAR)
    -- Hide trasure caskets
    -- Deaggro Mobs
    -- Deaggro Pets
    -- Despawn Mobs
    -- clear all local vars? lamps, mobs, bosses

    -- close all doors
    setDoorAnimations(instance, {}, false, true)

    -- remove NM flag if set for specified enemy
    local specifiedEnemyID  = instance:getLocalVar("Nyzul_Specified_Enemy")
    if (specifiedEnemyID) then
        local specifiedEnemy = GetMobByID(specifiedEnemyID, instance)
        specifiedEnemy:setNM(false)
        instance:setLocalVar("Nyzul_Specified_Enemy", 0)
    end

end



--[[
    ToDo:
        - Complete Floor Mappings to get to 36+
]]