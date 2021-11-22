-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Spook 
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end 
