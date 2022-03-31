-----------------------------------
-- Area: Giddeus (145)
--   NM: Zhuu Buxu the Silent
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(780, 1560)) -- 13 to 26 minutes
end