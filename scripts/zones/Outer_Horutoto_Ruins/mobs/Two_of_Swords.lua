-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Two of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    amkHelpers.cardianOrbDrop(mob, player)
end
