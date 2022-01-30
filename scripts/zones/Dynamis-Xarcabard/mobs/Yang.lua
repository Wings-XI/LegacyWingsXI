-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Yang
-----------------------------------
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

local zone = 135

function onMobInitialize(mob, target)
end

function onMobSpawn(mob)
    local dynaLord = GetMobByID(17330177)
    if dynaLord:getLocalVar("physImmune") < 2 then -- both dragons have not been killed initially
        dynaLord:setMod(tpz.mod.UDMGPHYS, -100)
        dynaLord:setMod(tpz.mod.UDMGRANGE, -100)
        dynaLord:setLocalVar("physImmune", 0)
        mob:setSpawn(-364, -35.974, 24.254) -- Reset Yang's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobFight(mob, target)
    local ying = GetMobByID(17330183)
    local yingToD = mob:getLocalVar("yingToD")
    -- Repop Ying every 30 seconds if Yang is up and Ying is not.
    if not ying:isSpawned() and os.time() > yingToD + 30 then
        ying:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        ying:spawn()
        ying:updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller)
    local ying = GetMobByID(17330183)
    if isKiller then
        if ying:isAlive() == true then
            mob:showText(mob, ID.text.YANG_DIALOG)
        else
            mob:showText(mob, ID.text.YANG_DIALOG +2)
        end
    end

    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobDespawn(mob)
    local ying = GetMobByID(17330183)
    local dynaLord = GetMobByID(17330177)
    -- localVars clear on death, so setting it on its partner
    ying:setLocalVar("yangToD", os.time())
    if dynaLord:getLocalVar("physImmune") == 0 then
        dynaLord:setMod(tpz.mod.UDMGPHYS, 0)
        dynaLord:setMod(tpz.mod.UDMGRANGE, 0)
        if dynaLord:getLocalVar("magImmune") == 1 then -- other dragon is also dead
            dynaLord:setLocalVar("physImmune", 2)
            dynaLord:setLocalVar("magImmune", 2)
        else
            dynaLord:setLocalVar("physImmune", 1)
        end
    end
end
