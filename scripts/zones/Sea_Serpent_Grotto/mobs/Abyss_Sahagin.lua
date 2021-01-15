-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Abyss Sahagin
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
    mob:setRespawnTime(math.random(1200, 1500)) -- 20 to 25 minutes
end
