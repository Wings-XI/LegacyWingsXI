-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Bunny
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 40

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMobStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Buburimu/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end
