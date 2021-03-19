-----------------------------------
-- Area: Manaclipper
--   NM: Zoredonite
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(43200) -- 12 hours
end
