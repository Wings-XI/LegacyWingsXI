-----------------------------------
-- Area: Beadeaux [S]
--   NM: Blifnix Oilycheeks
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(14400, 18000)
    mob:setRespawnTime(respawn) -- 4 to 5 hours
    SetServerVariable("Blifnix_Oilycheeks_Respawn", (os.time() + respawn))
end
