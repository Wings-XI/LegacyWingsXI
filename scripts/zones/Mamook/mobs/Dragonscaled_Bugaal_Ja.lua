-----------------------------------
-- Area: Mamook
--   NM: Dragonscaled Bugaal Ja
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(100800, 259200)
    mob:setRespawnTime(respawn) -- 28 to 72 hours 
    SetServerVariable("Dragonscaled_Bugaal_Respawn", (os.time() + respawn))
end
