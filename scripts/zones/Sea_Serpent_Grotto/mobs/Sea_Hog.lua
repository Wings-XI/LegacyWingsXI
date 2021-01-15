------------------------------
-- Area: Sea Serpent Grotto
--   NM: Sea Hog
------------------------------
-- mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
require("scripts/globals/status")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 376)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3600)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5400)
end