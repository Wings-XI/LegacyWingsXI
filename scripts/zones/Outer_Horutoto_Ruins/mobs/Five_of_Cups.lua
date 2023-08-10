-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Five of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 664, 1, tpz.regime.type.GROUNDS)
    amkHelpers.cardianOrbDrop(mob, player)
end
