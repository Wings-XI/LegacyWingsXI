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
-- Constants
--------------------------------------------------------
local FREE_FLOOR_CHANCE = 5 -- 5% chance of a free floor

---------------------------------------------------------------------------------------
-- Generates the Nyzul Isle Floor
-- Returns: Rune of transfer spawnpoint, Floor objective, Floor SubObject, List of Mobs
-- The list of mobs are the mobs required to be killed for objective clear (can be nil)
---------------------------------------------------------------------------------------
function generateFloor(floorNumber, instance)
    -- randomly generate a free floor
    if (math.Random(1, 100) < FREE_FLOOR_CHANCE) then
        runeOfTransferSpawnPoint = generateFreeFloor(floorNumber, instance)
        return runeOfTransferSpawnPoint, "FREE_FLOOR", nil, nil
    end

    if (floorNumber % 20 == 0) then
        runeOfTransferSpawnPoint, bossID = generateBossFloor(floorNumber, instance)
        return runeOfTransferSpawnPoint, "ELIMINATE_ENEMY_LEADER", nil, {bossID} 
    end

    --otherwise generate a standard floor
    local activeRuneOfTransfer = selectRuneOfTransfer(floorNumber, instance)
    local archaicRampartID = selectArchaicRampartID(floorNumber, instance)

    return objective, subObjective, objectiveMobs
end

-------------------------------------------------------
--
--
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
function selectArchaicRampartID(floorNumber, instance)
    local archaicRampart

    if ((floorNumber % 2) == 0) then -- even floor
        archaicRampart = 17092629
    else
        archaicRampart = 17092630
    end

    return archaicRampart
end

-------------------------------------------------------
-- Performs all work for generating a Free Floor
--
-------------------------------------------------------
function generateFreeFloor(floorNumber, instance)
    -- pick a floor
    -- get rune of transfer
    local activeRuneOfTransfer = selectRuneOfTransfer(floorNumber, instance)
    -- spawn runeOfTransfer
    -- set runeOfTransferAnimation to lit
    -- spawn 5-10 Armoury_Crates with temp items
    return runeOfTransferSpawnPoint
end

-------------------------------------------------------
-- Performs all work for generating a Boss Floor
--
-------------------------------------------------------
function generateBossFloor(floorNumber, instance)
    -- randomize a boss floor
    local bossFloorKey = tpz.nyzul_isle_data.bossFloorTableKeys[math.random(#tpz.nyzul_isle_data.bossFloorTableKeys)]
    local bossFloor = tpz.nyzul_isle_data.bossFloorLayouts[bossFloorKey]
    

    -- get and setup entities that alternate per floor
    local runeOfTransferSpawnPoint = bossFloor.RuneOfTransferSpawnPoint
    local activeRuneOfTransfer = selectRuneOfTransfer(floorNumber, instance, runeOfTransferSpawnPoint)
    local archaicRampartID = selectArchaicRampartID(floorNumber, instance)


    -- Randomly pick a boss from BOSSES_20_60 or BOSSES_80_100 depending on floor
    local possibleNMs
    if (floorNumber == 80 or floorNumber == 100) then
        possibleNMs = tpz.nyzul_isle_data.mobsByType.BOSSES_80_100.Bosses
    else
        possibleNMs = tpz.nyzul_isle_data.mobsByType.BOSSES_20_60.Bosses
    end
    local bossID = possibleNMs[math.random(#possibleNMs)]

    -- randomize a boss spawn point
    local bossSpawnPoint = bossFloor.BossSpawnPoints[math.random(#bossFloor.BossSpawnPoints)]

    -- randomize an archaicRampart spawn, removing the boss spawn point
    local remainingSpawnPoints = {}
    for key, value in pairs(bossFloor.RampartSpawnPoints) do
        table.insert(remainingSpawnPoints, value)
    end
    table.remove(remainingSpawnPoints, bossSpawnPoint)
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
----------------------------------------------------------------------------------------------
function setBossWeaponDrop(bossID, instance)
    local players = instance:getChars()
    local job
    if (players[1] ~= nil) then
        job = players[1]:getCharVar("Nyzul_DiscUserJob")
    end

    if (job ~= nil) then
        local boss = GetMobByID(bossID, instance)
        boss:setLocalVar("ForceDropWeapon", tpz.nyzul_isle_data.jobToVigilWeaponMap[player:getMainJob()])
    end
end

-------------------------------------------------------
-- Cleans up the previous floor as players teleport to the new floor
--
-------------------------------------------------------
function cleanUpPreviousFloor(instance)
    -- Hide lamps
    -- Hide runeOfTransfer
    -- Deaggro Mobs
    -- Deaggro Pets
    -- Despawn Mobs
    -- clear all local vars?

    --runeOfTransfer:setStatus(tpz.status.DISAPPEAR)

end



--[[
    ToDo:
        - Complete Floor Mappings to get to 36+
]]