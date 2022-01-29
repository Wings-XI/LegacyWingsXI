-----------------------------------
--
-- Dynamis-Qufim
--
-----------------------------------
local ID = require("scripts/zones/Dynamis-Qufim/IDs")
require("scripts/zones/Dynamis-Qufim/dynamis_mobs")
require("scripts/globals/dynamis")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------

local zone = tpz.zone.DYNAMIS_QUFIM

function onDynamisTick(timeRemaining)
    -- haven't had a reason to use this yet, for now this function is disabled for optimization purposes (a lua callback every server tick!!)
    -- if this is needed, uncomment line //luautils::OnDynamisTick(this); in file dynamis_handler.cpp and build
end

function onDynamisNewInstance()
    package.loaded["scripts/zones/Dynamis-Qufim/dynamis_mobs"] = nil
    require("scripts/zones/Dynamis-Qufim/dynamis_mobs")
    
    local iStart = 4096*4096+(4096*zone)
    local i = iStart
    local iEnd = iStart + 1023
    
    if npcList == nil then print("npcList was nil") end
    if npcList[zone] == nil then print("npcList[zone] was nil") end
    
    while i <= iEnd do
        entity = GetEntityByID(i)
        if entity ~= nil and entity:isNPC() then entity:setStatus(tpz.status.DISAPPEAR) end
        
        if mobList[zone][i] ~= nil then
            local mob = GetMobByID(i)
            mob:setNM(true)
            mob:resetLocalVars()
            if mobList[zone][i].pos ~= nil then
                mob:setSpawn(mobList[zone][i].pos[1],mobList[zone][i].pos[2],mobList[zone][i].pos[3],mobList[zone][i].pos[4])
                if mobList[zone][i].waves ~= nil and mobList[zone][i].waves[1] ~= nil then SpawnMob(i) end
            else mob:setSpawn(1,1,1,0) end
            mob:addRoamFlag(256) -- scripted pathing only
        elseif npcList[zone][i] ~= nil and npcList[zone][i].spawnAtStart ~= nil then
            GetNPCByID(i):setStatus(tpz.status.NORMAL)
        end
        i = i + 1
    end
end

function onDynamisCleanup()
    local iStart = 4096*4096+(4096*zone)
    local i = iStart
    local iEnd = iStart + 1023
    local entity = nil
    
    while i <= iEnd do
        entity = GetEntityByID(i)
        if entity ~= nil then
            if entity:isMob() then
                DespawnMob(i, 0)
            elseif entity:isNPC() then
                entity:setStatus(tpz.status.DISAPPEAR)
            end
        end
        i = i + 1
    end
end

function onDynamisEjectPlayer(player, immediate)
    local ejectPos = dynamis.dynaInfo[zone].ejectPos
    if ejectPos == nil then
        print("onDynamisEjectPlayer error! No ejectPos is set in dynamis.lua under table dynaInfo for this zoneID!")
        return
    end
    if immediate == true then
        player:timer(1000, function(player) player:setPos(ejectPos[1],ejectPos[2],ejectPos[3],ejectPos[4],ejectPos[5]) end)
    else
        if ID.text.NO_LONGER_HAVE_CLEARANCE ~= nil then player:timer(1000, function(player) player:messageSpecial(ID.text.NO_LONGER_HAVE_CLEARANCE, 0, 30) end) end
        player:timer(25000, function(player)
            -- player:addHP(9999) -- there is currently a bug where if a dead player gets force-zoned, they cannot homepoint
            -- player:addMP(9999) -- unable to reproduce the bug - commenting these for now (2022-01-18)
            player:startEvent(100)
        end)
        player:timer(30000, function(player) player:setPos(ejectPos[1],ejectPos[2],ejectPos[3],ejectPos[4],ejectPos[5]) end)
    end
end

function onDynamisTimeWarning(player, timeRemaining)
    if timeRemaining < 1 and ID.text.DYNAMIS_TIME_EXPIRED ~= nil then player:messageSpecial(ID.text.DYNAMIS_TIME_EXPIRED)
    else
        local minutes = math.floor(timeRemaining/60)
        if minutes == 1 then player:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_1, minutes, 1)
        elseif ID.text.DYNAMIS_TIME_UPDATE_2 ~= nil then player:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_2, minutes, 1) end
    end
end
