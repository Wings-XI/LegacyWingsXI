-----------------------------------
-- Area: Mamook
--  Mob: Darting Kachaal Ja
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = 259200
    mob:setRespawnTime(respawn) -- 72 hours 
    SetServerVariable("Darting_Kachaal_Ja_Respawn", (os.time() + respawn))
end