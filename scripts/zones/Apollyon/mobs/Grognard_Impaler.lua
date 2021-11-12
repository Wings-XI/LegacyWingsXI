-----------------------------------
-- Area: Apollyon CS
--  Mob: Grognard Impaler
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.CALL_WYVERN, hpp = 100},
        },
    })

    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobDeath(mob, player, isKiller)
end

