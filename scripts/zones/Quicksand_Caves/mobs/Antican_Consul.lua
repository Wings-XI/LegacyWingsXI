-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Consul
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(75600, 86400)
    mob:setRespawnTime(respawn) -- 21 to 24 hours
    SetServerVariable("Consul_Respawn", (os.time() + respawn))
end
