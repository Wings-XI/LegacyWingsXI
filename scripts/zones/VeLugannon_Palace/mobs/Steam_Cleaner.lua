-----------------------------------
-- Area: Ve'Lugannon Palace
--   NM: Steam Cleaner
-----------------------------------

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    SetServerVariable("SteamCleaner_Respawn", (os.time() + 7200))
end
