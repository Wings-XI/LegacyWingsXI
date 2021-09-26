-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JOJ
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIJIN_GAKURE, hpp = math.random(25, 35)},
        },
    })
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:addStatusEffectEx(tpz.effect.FLEE, 0, 100, 0, 60)
end

function onMobDeath(mob, player, isKiller)
end
