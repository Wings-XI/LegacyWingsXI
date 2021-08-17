-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Goblin Statue
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

local zone = 188

function onMobSpawn(mob)
    if mob:getID() == 17547957 then mob:speed(0) end -- statue 293 cannot be pulled out of palace
    require("scripts/zones/Dynamis-Jeuno/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setStatueStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Jeuno/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Jeuno/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end
