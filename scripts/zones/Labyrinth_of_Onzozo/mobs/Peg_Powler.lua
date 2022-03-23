-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Peg Powler
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 9000)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 297)
    tpz.regime.checkRegime(player, mob, 774, 1, tpz.regime.type.GROUNDS)
end
