-----------------------------------
-- Area: North Gustaberg
--  Mob: Walking Sapling
-- Note: Place Holder For Maighdean Uaine
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 18, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MAIGHDEAN_UAINE_PH, 5, 15) -- 15 minute minimum respawn
end
