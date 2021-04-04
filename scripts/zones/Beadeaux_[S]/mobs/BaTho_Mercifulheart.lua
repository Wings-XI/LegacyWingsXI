-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ba'Tho Mercifulheart
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    mob:addMod(tpz.mod.DOUBLE_ATTACK, 25)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, duration = 30, hpp = 60},
        },
    })
end
-----------------------------------

function onMobDeath(mob, player, isKiller)
end
