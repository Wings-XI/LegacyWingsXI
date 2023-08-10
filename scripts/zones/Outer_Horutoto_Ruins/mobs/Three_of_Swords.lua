-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Three of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    amkHelpers.cardianOrbDrop(mob, player)
end
