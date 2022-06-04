-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Nephiyl Rampartbreacher
-- BCNM: Demolition Squad
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 25)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 25)
end


function onMobDeath(mob, player, isKiller)
end
