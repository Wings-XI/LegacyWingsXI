-----------------------------------
-- Area: East Ronfaure
--  Mob: Carrion Worm
-- Note: PH for Bigmouth Billy
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 65, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BIGMOUTH_BILLY_PH, 10, 3600) -- 1 hour minimum
end
