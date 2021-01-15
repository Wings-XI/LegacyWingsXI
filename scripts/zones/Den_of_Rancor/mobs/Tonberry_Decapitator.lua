-----------------------------------
-- Area: Den of Rancor
--   NM: Tonberry Decapitator
-----------------------------------
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 798, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 799, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 800, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(1260, 1440)) -- 21 to 24 minutes
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 9000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 11000)
end