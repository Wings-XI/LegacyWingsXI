-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Mee Deggi the Punisher
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobDeath(mob, player, isKiller)
end
