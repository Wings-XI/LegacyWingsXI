-----------------------------------
-- Area: La Vaule [S]
--   NM: Feeblescheme Bhogbigg
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(7200, 14400)
    mob:setRespawnTime(respawn) -- 2 to 4 hours
    SetServerVariable("Feeblescheme_Bhogbigg_Respawn", (os.time() + respawn))
end
