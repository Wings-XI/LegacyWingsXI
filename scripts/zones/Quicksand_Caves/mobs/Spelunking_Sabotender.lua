-----------------------------------
-- Area: Quicksand Caves
--  Mob: Spelunking Sabotender
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 816, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    if (mob:getID() == 17629582) then -- PH will randomize spawn points
        UpdateNMSpawnPoint(mob:getID()) -- ToDo: rename fcn to RandomizeSpawnPoint, rename dbtable to mob_spawn_points_randomized?
    end
    tpz.mob.phOnDespawn(mob, ID.mob.SABOTENDER_BAILARINA_PH, 5, 21600) -- 6 hour cooldown based on varying reports from wiki/alla 
end