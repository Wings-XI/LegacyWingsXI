-----------------------------------
-- Area: La Vaule [S]
--   NM: Cogtooth Skagnogg
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(7200, 14400)
    mob:setRespawnTime(respawn) -- 2 to 4 hours
    SetServerVariable("Cogtooth_Skagnogg_Respawn", (os.time() + respawn))
end
