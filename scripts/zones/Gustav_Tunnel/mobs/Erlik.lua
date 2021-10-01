-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Erlik
-- Note: PH for Baobhan Sith
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 767, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BAOBHAN_SITH_PH, 5, 3600) -- 1 hour
end
