-----------------------------------
-- Area: Davoi
--   NM: Dirtyhanded Gochakzuk
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.FASTCAST, 30)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:addMod(tpz.mod.SILENCERES, 100)
end

function onMobDeath(mob, player, isKiller)
end
