-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Ocean Sahagin
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(75600, 86400)
    mob:setRespawnTime(respawn) -- 21-24 hours
    SetServerVariable("Ocean_Sahagin_Respawn", (os.time() + respawn))
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 12000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 15000)
end