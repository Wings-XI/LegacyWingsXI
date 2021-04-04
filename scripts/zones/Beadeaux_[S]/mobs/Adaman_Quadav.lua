-----------------------------------
-- Area: Beadeaux [S]
--  Mob: Adaman Quadav
-- Note: PH for Ea'Tho Cruelheart and Ba'Tho Mercifulheart
-----------------------------------
local ID = require("scripts/zones/Beadeaux_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.EATHO_CRUELHEART_PH, 10, math.random(7200, 14400)) -- 2-4 hours
    tpz.mob.phOnDespawn(mob, ID.mob.BATHO_MERCIFULHEART_PH, 10, math.random(7200, 28800)) -- 2-8 hours
end
