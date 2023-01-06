-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Worm
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 42

local spawnSpots = {
    {0, -22, -24.6},
    {-18.6, -22, -19},
    {-25, -22, 0},
    {-18, -22, 19},
    {0, -22, 22.5},
    {28, -22, 3},
}

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMobStats(mob)

    mob:setLocalVar("spawnSpot", math.random(#spawnSpots))

    mob:setSpawn(spawnSpots[mob:getLocalVar("spawnSpot")])
    mob:setPos(spawnSpots[mob:getLocalVar("spawnSpot")])
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Tavnazia/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)

    local winQM = GetNPCByID(ID.mobs.winQM)
    if GetMobByID(ID.mobs.Nightmare_Antlion):isDead() then
        SetServerVariable(string.format("DynamisSJRestriction_%s", zoneID), 1)
        dynamis.sjQMOnTrigger(winQM, winQM)
    end
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end
