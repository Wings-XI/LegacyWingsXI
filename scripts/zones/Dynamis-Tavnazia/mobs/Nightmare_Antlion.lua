-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Antlion
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland"),
        require("scripts/mixins/families/antlion_ambush")}

require("scripts/globals/dynamis")
-----------------------------------

local zone = 42

-- code assumes exactly 4 spawnspots and exactly 3 dummyWorms
local spawnSpots = {
   { 17,    -36,     19}, -- NE
   {-20,    -36,     19}, -- NW
   {-19,    -36,    -19}, -- SW
   { 17,    -36,    -19}, -- SE
}

local dummyWorms = {
    16949443,
    16949444,
    16949445,
}

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMobStats(mob)

    mob:setLocalVar("spawnSpot", math.random(#spawnSpots))

    mob:setSpawn(spawnSpots[mob:getLocalVar("spawnSpot")])
    mob:setPos(spawnSpots[mob:getLocalVar("spawnSpot")])

    mob:setMod(tpz.mod.HPP, mob:getMod(tpz.mod.HPP) + 50)
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


    for i = 1, 3 do
        DespawnMob(dummyWorms[i])
    end
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)

    for i = 1, 3 do
        local wormID = dummyWorms[i]
        local worm = GetMobByID(wormID)
        local wormPos = i
        if i >= mob:getLocalVar("spawnSpot") then
            wormPos = i + 1
        end
        worm:setSpawn(spawnSpots[wormPos])
        worm:setPos(spawnSpots[wormPos])
    end
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)

    mob:setMod(tpz.mod.REGAIN, 500)
end
