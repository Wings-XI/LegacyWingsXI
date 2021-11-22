------------------------------
-- Area: Palborough Mines
--   NM: Be'Hya Hundredwall
------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
require("scripts/globals/status")
------------------------------

function onMobSpawn(mob)
    mob:addStatusEffect(tpz.effect.STONESKIN, math.random(60, 70), 0, 300)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 222)
end
