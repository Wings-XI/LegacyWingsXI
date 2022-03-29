-----------------------------------
-- Area: Arrapago Reef
--   NM: Merrow No. 5
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
end

function onAdditionalEffect(mob, target, damage)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local respawn = math.random(86400, 259200)
    mob:setRespawnTime(respawn) -- 24-72 hours
    SetServerVariable("Merrow_No5_Respawn", (os.time() + respawn))
end
