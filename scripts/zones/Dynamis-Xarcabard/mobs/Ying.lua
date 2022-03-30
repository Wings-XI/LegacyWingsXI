-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Ying
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
    if dynaLord:getLocalVar("magImmune") < 2 then -- both dragons have not been killed initially
        dynaLord:setMod(tpz.mod.UDMGMAGIC, -100)
        dynaLord:setMod(tpz.mod.UDMGBREATH, -100)
        dynaLord:setLocalVar("magImmune", 0)
        mob:setSpawn(-364, -35.661, 17.254) -- Reset Ying's spawn point to initial spot.
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
    local yang = GetMobByID(17330184)
    local yangToD = mob:getLocalVar("yangToD")
    -- Repop Yang every 30 seconds if Ying is up and Yang is not.
    if not yang:isSpawned() and os.time() > yangToD + 30 then
        yang:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        yang:spawn()
        yang:updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller)
    local yang = GetMobByID(17330184)
    if isKiller then
        if yang:isAlive() == true then
            mob:showText(mob, ID.text.YING_DIALOG)
        else
            mob:showText(mob, ID.text.YING_DIALOG +2)
            SetServerVariable("MainDynaLord", ID.mob.DYNAMIS_LORD)
        end
    end

    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobDespawn(mob)
    local yang = GetMobByID(17330184)
    local dynaLord = GetMobByID(17330177)
    -- localVars clear on death, so setting it on its partner
    yang:setLocalVar("yingToD", os.time())
    if dynaLord:getLocalVar("magImmune") == 0 then
        dynaLord:setMod(tpz.mod.UDMGMAGIC, 0)
        dynaLord:setMod(tpz.mod.UDMGBREATH, 0)
        if dynaLord:getLocalVar("physImmune") == 1 then -- other dragon is also dead
            dynaLord:setLocalVar("physImmune", 2)
            dynaLord:setLocalVar("magImmune", 2)
        else
            dynaLord:setLocalVar("magImmune", 1)
        end
    end
end
