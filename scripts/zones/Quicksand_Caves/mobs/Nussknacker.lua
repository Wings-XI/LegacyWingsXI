------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
--  POS: 192.146 2.079 2.149
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("wasKilled", 0)
end

function onMobRoam(mob)
    local weather = mob:getWeather()
    
    if (weather ~= tpz.weather.DUST_STORM and weather ~= tpz.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob)
    local weather = mob:getWeather()

    if (weather ~= tpz.weather.DUST_STORM and weather ~= tpz.weather.SAND_STORM) then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 435)
    if isKiller then
        mob:setLocalVar("wasKilled", 1)
    end
end

function onMobDespawn(mob, player)
    if mob:getLocalVar("wasKilled") ~= 1 then
        mob:setLocalVar("preservePop", 1)
    end
end
