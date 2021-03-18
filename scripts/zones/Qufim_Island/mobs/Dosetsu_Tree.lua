-----------------------------------
-- Area: Qufim Island
--  MOB: Dosetsu Tree
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/world")
-----------------------------------

function onMobRoam(mob)
    if not (mob:getWeather() == tpz.weather.THUNDER or mob:getWeather() == tpz.weather.THUNDERSTORM) then
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob, weather)
    if not (mob:getWeather() == tpz.weather.THUNDER or mob:getWeather() == tpz.weather.THUNDERSTORM) then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setLocalVar("pop", os.time() + math.random(32400, 43200))
end