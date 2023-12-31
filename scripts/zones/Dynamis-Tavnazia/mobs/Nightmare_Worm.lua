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

    mob:setMod(tpz.mod.HPP, mob:getMod(tpz.mod.HPP) + 50)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Tavnazia/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)

    local winQM = GetNPCByID(ID.mobs.winQM)
    if GetMobByID(ID.mobs.Nightmare_Antlion):isDead() then
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

function onMobWeaponSkill(target, mob, skill)
    -- Draw In: Always used before a TP move; draws in the person with the most hate and anyone in his alliance (changed to party only as QoL) regardless of their position in the zone.
    local drawInTarget = target
    if drawInTarget ~= nil then
        if target:isPet() then
            drawInTarget = drawInTarget:getMaster()
        end
        for _, member in ipairs(drawInTarget:getParty()) do
            if member:isPet() == false then
                mob:triggerDrawIn(false, 1, nil, member)
            end
        end
    end
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)

    mob:setMod(tpz.mod.REGAIN, 500)
end
