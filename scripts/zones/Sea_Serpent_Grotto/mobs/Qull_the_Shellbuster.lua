-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Qull the Shellbuster
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 373)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3600)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5400)
end