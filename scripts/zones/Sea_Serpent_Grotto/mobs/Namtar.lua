-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Namtar
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 369)
    tpz.regime.checkRegime(player, mob, 805, 2, tpz.regime.type.GROUNDS)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 1200)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 1800)
end