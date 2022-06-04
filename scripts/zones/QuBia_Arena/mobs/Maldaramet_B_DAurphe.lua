-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Maldaramet B D'Aurphe
-- BCNM: Brothers D'Aurphe
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.LULLABYRESTRAIT, 75)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 25)
end


function onMobDeath(mob, player, isKiller)
end
