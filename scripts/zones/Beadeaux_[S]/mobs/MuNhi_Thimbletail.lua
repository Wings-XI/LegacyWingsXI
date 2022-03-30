-----------------------------------
-- Area: Beadeaux [S]
--   NM: Mu'Nhi Thimbletail
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = 18000
    mob:setRespawnTime(respawn) -- 5 hours
    SetServerVariable("MuNhi_Thimbletail_Respawn", (os.time() + respawn))
end
