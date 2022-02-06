-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Fly
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39
local zoneID = zones[tpz.zone.DYNAMIS_VALKRUM]

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Valkrum/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMobStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Valkrum/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Valkrum/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    -- Spawn QM0
    -- If Nightmare FLy 1 was last alive:
    if GetMobByID(zoneID.mobs.Nightmare_Fly_2):getStatus() == 2 and GetMobByID(zoneID.mobs.Nightmare_Fly_3):getStatus() == 2 then
        local sjQM = GetNPCByID(16937585)
        local pos = mob:getPos()
        sjQM:setPos(pos.x,pos.y,pos.z,pos.rot)
        sjQM:setStatus(tpz.status.NORMAL)
    -- If Nightmare Fly 2 was last alive:
    elseif GetMobByID(zoneID.mobs.Nightmare_Fly_1):getStatus() == 2 and GetMobByID(zoneID.mobs.Nightmare_Fly_3):getStatus() == 2 then
        local sjQM = GetNPCByID(16937585)
        local pos = mob:getPos()
        sjQM:setPos(pos.x,pos.y,pos.z,pos.rot)
        sjQM:setStatus(tpz.status.NORMAL)
    -- If Nightmare Fly 3 was last alive:
    elseif GetMobByID(zoneID.mobs.Nightmare_Fly_2):getStatus() == 2 and GetMobByID(zoneID.mobs.Nightmare_Fly_1):getStatus() == 2 then
        local sjQM = GetNPCByID(16937585)
        local pos = mob:getPos()
        sjQM:setPos(pos.x,pos.y,pos.z,pos.rot)
        sjQM:setStatus(tpz.status.NORMAL)
    end
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Valkrum/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end
