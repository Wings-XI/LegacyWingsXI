-----------------------------------
-- Area: Den of Rancor
--   NM: Tonberry Tracker
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

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 6000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9500)
end