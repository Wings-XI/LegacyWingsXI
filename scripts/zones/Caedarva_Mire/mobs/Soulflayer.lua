-----------------------------------
-- Area: Caedarva Mire
--  Mob: Soulflayer
--  Note: PH for Vidhuwa the Wrathborn
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    -- no real data on repsawn on wiki, bg, wikiwiki.jp, ffxiah, etc
    -- going with the defaults we have for Lyft NMs
    tpz.mob.phOnDespawn(mob, ID.mob.VIDHUWA_PH, 20, 3600) -- 1 hour
end
