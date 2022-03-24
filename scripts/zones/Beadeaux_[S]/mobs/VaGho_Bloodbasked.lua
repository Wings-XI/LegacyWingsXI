-----------------------------------
-- Area: Beadeaux [S]
--   NM: Va'Gho Bloodbasked
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(14400, 18000)
    mob:setRespawnTime(respawn) -- 4 to 5 hours
    SetServerVariable("VaGho_Bloodbasked_Respawn", (os.time() + respawn))
end
