-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Stihi
-----------------------------------

-----------------------------------

local zone = 40

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Buburimu/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
    mob:setTP(0)
end


function onMobFight(mob)
    mob:setMod(tpz.mod.REGAIN, 1250)
end

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setNMStats(mob)
    mob:SetAutoAttackEnabled(false)
end