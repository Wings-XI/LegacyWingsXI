-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Sulfur Scorpion
-- Note: PH for Tyrannic Tunnok
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 759, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TYRANNIC_TUNNOK_PH, 5, 3600) -- 1 hour
end
