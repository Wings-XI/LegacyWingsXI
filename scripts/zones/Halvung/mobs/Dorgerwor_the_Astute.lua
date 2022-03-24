-----------------------------------
-- Area: Halvung
--   NM: Dorgerwor the Astute
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = 259200
    mob:setRespawnTime(respawn) -- 72 hours
    SetServerVariable("Dorgerwor_Astute_Respawn", (os.time() + respawn))
end
