-----------------------------------
-- Area: Gusgen Mines
--   NM: Juggler Hecatomb
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(75600, 86400)
    mob:setRespawnTime(respawn) -- 21 to 24 hours 
    SetServerVariable("Juggler_Hecatomb_Respawn", (os.time() + respawn))
end

