-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Coral Sahagin
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 6000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9400)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(1200, 2700)) -- 20 to 45 minutes
end
