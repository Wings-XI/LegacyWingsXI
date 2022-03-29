-----------------------------------
-- Area: La Vaule [S]
--   NM: Agrios
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(7200, 14400)
    mob:setRespawnTime(respawn) -- 2 to 4 hours
    SetServerVariable("Agrios_Respawn", (os.time() + respawn))
end
