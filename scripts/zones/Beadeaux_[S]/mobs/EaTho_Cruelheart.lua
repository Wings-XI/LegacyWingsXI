-----------------------------------
-- Area: Beadeaux [S] (92)
-- NM: Ea'Tho Cruelheart !spawnmob 17154069
-- !pos -191.758 0.500 -59.651 92
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 8000)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    mob:addMod(tpz.mod.GRAVITYRESTRAIT, 10)
    mob:addMod(tpz.mod.RESBUILD_GRAVITY, 10)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 10)
    mob:addMod(tpz.mod.LULLABYRESTRAIT, 10)
    mob:addMod(tpz.mod.BINDRESTRAIT, 10)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, duration = 30, hpp = math.random(15, 50)},
        },
    })
end

function onMobDeath(mob, player, isKiller)
end
