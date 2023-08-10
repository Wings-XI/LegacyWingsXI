-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Two of Coins
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    amkHelpers.cardianOrbDrop(mob, player)
end
