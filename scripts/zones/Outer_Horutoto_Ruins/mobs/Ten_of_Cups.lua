-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Ten of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    amkHelpers.cardianOrbDrop(mob, player)
end
