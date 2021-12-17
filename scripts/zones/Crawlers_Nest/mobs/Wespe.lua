-----------------------------------
-- Area: Crawlers' Nest (197)
--  Mob: Wespe
-- Note: PH for Demonic Tiphia
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 691, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DEMONIC_TIPHIA_PH, 5, 7200) -- 2 hour minimum
end
