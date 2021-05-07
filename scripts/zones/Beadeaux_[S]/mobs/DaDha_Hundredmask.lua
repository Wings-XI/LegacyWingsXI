-----------------------------------
-- Area: Beadeaux [S] (92)
--   NM: Da'Dha Hundredmask !spawnmob 17154195
-- !pos -89.901 .225 -159.694 92
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 8000)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    mob:addMod(tpz.mod.EVA, 50)
    mob:addMod(tpz.mod.ACC, 50)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 10)
    mob:addMod(tpz.mod.SLOWRESTRAIT, 10)
    mob:addMod(tpz.mod.BLINDRESTRAIT, 10)
    mob:addMod(tpz.mod.BINDRESTRAIT, 10)
    mob:addMod(tpz.mod.GRAVITYRESTRAIT, 80)


    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.PERFECT_DODGE, duration = 30, hpp = math.random(5,65)},
        },
    })
end

function onMobDeath(mob, player, isKiller)
end
