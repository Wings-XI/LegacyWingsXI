------------------------------
-- Area: Pashhow Marshlands
--   NM: Toxic Tamlyn
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
end

function onMobRoam(mob)
    if not (mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL) then
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob)
    if not (mob:getWeather() == tpz.weather.RAIN or mob:getWeather() == tpz.weather.SQUALL) then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 213)
end

function onMobDespawn(mob)
    DisallowRespawn(mob:getID(), true)
    SetServerVariable("TamlynRespawn",(os.time() + 3600))
end
