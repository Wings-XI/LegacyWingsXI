-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Slendlix Spindlethumb
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        chance = 50,
    })
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 289)
end
