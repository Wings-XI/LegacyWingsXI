-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Antlion
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland"),
        require("scripts/mixins/families/antlion_ambush")}

require("scripts/globals/dynamis")
-----------------------------------

local zone = 42


local spawnSpots = {
   { 17,    -36,     19}, -- NE
   {-20,    -36,     19}, -- NW
   {-19,    -36,    -19}, -- SW
   { 17,    -36,    -19}, -- SE
}

--[[function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1455)
    mob:setMobMod(tpz.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(tpz.mobMod.ROAM_RATE, 0)
    mob:setMobMod(tpz.mobMod.ROAM_DISTANCE, 0)
    mob:setLocalVar("spawnSpot", math.random(#spawnSpots))

    mob:setPos(spawnSpots[mob:getLocalVar("spawnSpot")])
end]]

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
    if GetMobByID(ID.mobs.Nightmare_Worm):isDead() then
        SetServerVariable(string.format("DynamisSJRestriction_%s", zone), 1)
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
