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
            {id = tpz.jsa.MIJIN_GAKURE, hpp = math.random(15, 35)},
        },
    })
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
end

function onMobDeath(mob, player, isKiller)
end
