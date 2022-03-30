-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Fleshgnasher
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(7200, 14400)
    mob:setRespawnTime(respawn) -- 2 to 4 hrs
    SetServerVariable("Fleshgnasher_Respawn", (os.time() + respawn))
end
