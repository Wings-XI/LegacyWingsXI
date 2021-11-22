-----------------------------------
-- Area: Riverne - Site A01
--   NM: Aiatar
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end 
