-----------------------------------
-- Area: South Gustaberg
--  Mob: Rock Lizard
-- Note: Place holder Leaping Lizzy
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 80, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.LEAPING_LIZZY_PH, 9, 1) -- No respawn timer, Leaping Lizzy can pop back to back
end