-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Nephiyl Moatfiller
-- BCNM: Demolition Squad
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 25)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 25)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 10)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 10)
end


function onMobDeath(mob, player, isKiller)
end
