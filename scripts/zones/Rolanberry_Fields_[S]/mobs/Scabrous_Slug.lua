-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Scabrous Slug
-- Note: PH for Delicieuse Delphine
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

-- TODO: Add regen on rainy weather to all slugs via an extended family mod system - dont replicate across all slug mob lua files

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DYINYINGA_PH, 10, 3600) -- 1 hour cooldown 10% pop chance, reports of 1-2 hour respawn
end
