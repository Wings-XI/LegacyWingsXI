-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ra'Dha Scarscute
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = 18000
    mob:setRespawnTime(respawn) -- 5 hours
    SetServerVariable("RaDha_Scarscute_Respawn", (os.time() + respawn))
end
