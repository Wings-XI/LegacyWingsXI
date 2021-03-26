-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Quu Domi the Gallant
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobDeath(mob, player, isKiller)
end
