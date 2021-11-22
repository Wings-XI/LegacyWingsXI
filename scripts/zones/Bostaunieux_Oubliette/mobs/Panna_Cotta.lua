-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Panna Cotta
-- Note: PH for Sewer Syrup
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 614, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 615, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SEWER_SYRUP_PH, 10, 7200) -- 2 hours
end
