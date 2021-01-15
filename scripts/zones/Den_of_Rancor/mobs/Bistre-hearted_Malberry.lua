-----------------------------------
-- Area: Den of Rancor
--   NM: Bistre-hearted Malberry
-----------------------------------
require("scripts/globals/hunts")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MANAFONT, hpp = math.random(40, 95)},
        },
    })

    mob:setMobMod(tpz.mobMod.GIL_MIN, 6000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 8000)

end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 397)
end
