-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Ten of Coins
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    amkHelpers.cardianOrbDrop(mob, player)
end
