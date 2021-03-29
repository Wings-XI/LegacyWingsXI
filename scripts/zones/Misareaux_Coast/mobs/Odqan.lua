------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/world")
require("scripts/globals/mobs")
require("scripts/globals/status")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
------------------------------

function onMobRoam(mob)
  if not mob:getWeather() == tpz.weather.FOG then
      DespawnMob(mob:getID())
  end
end

function onMobDisengage(mob, weather)
    if not mob:getWeather() == tpz.weather.FOG then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 443)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local Odqan  = GetMobByID(ID.mob.ODQAN)
    local respawn = math.random(7200, 18000) -- 2 to 5 hrs
    mob:setRespawnTime(respawn)
    SetServerVariable("OdqanRespawn",(os.time() + respawn))
    DisallowRespawn(Odqan:getID(), true)
end
