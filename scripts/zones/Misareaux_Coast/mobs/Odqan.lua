------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/world")
require("scripts/globals/mobs")
------------------------------

function onMobRoam(mob)
    if mob:getWeather() ~= tpz.weather.FOG then
        DespawnMob(mob:getID())
    end
end

function onMobDisengage(mob, weather)
    if mob:getWeather() ~= tpz.weather.FOG then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 443)
end

function onMobDespawn(mob)
    -- Mob has been known to pop in 2 games days which can be slightly less than 2 hours.
    -- Since mob spawn check only happens when FOG starts we will cut off 30 min
    -- This will still heavily favor it to spawn over 2 hours later
    local respawn = math.random(5400, 16200) -- 1.5 to 4.5 hrs (will be 2 to 5 ingame days)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(respawn)
    SetServerVariable("OdqanRespawn",(os.time() + respawn))
    DisallowRespawn(mob:getID(), true)
end
