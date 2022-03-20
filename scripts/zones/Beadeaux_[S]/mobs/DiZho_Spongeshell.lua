-----------------------------------
-- Area: Beadeaux [S]
--   NM: Di'Zho Spongeshell
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = 18000
    mob:setRespawnTime(respawn) -- 5 hours
    SetServerVariable("DiZho_Spongeshell_Respawn", (os.time() + respawn))
end
