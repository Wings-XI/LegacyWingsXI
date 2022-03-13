-----------------------------------
-- Area: La Vaule [S]
--  Mob: Orcish Bowshooter
-- Note: PH for Shatterskull Mippdapp
-----------------------------------
local ID = require("scripts/zones/La_Vaule_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SHATTERSKULL_MIPPDAPP_PH, 50, 14400) -- 4 hours
end
