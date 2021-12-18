-----------------------------------
-- Area: Apollyon CS
--  Mob: Yagudo Prelatess
-----------------------------------
mixins = {require("scripts/mixins/job_special")}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 10)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 10)
    mob:setMod(tpz.mod.SLASHRES, 5000)
    mob:setMod(tpz.mod.H2HRES, 1500)
    mob:setMod(tpz.mod.IMPACTRES, 5000)
    mob:setMod(tpz.mod.DMGMAGIC, -50)
end

function onMobDeath(mob, player, isKiller)
end
