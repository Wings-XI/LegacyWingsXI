-----------------------------------
-- Area: Gustav Tunnel
--   NM: Bune
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600, 86400) -- 21h to 24h
    mob:setRespawnTime(respawn)
    SetServerVariable("BuneRespawn",(os.time() + respawn))
end