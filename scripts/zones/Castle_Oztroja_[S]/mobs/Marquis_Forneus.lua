-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Marquis Forneus
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(18000, 21600)
    mob:setRespawnTime(respawn) -- 5 to 6 hours
    SetServerVariable("Marquis_Forneus_Respawn", (os.time() + respawn))
end
