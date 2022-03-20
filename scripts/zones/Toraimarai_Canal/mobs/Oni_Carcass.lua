-----------------------------------
-- Area: Toraimarai Canal
--   NM: Oni Carcass
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(75600, 86400)
    mob:setRespawnTime(respawn) -- 21-24 hours
    SetServerVariable("Oni_Carcass_Respawn", (os.time() + respawn))
end
