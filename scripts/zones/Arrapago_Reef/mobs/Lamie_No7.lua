-----------------------------------
-- Area: Arrapago Reef
--   NM: Lamie No. 7
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
    local respawn = 259200
    mob:setRespawnTime(respawn) -- 72 hours
    SetServerVariable("Lamie_No7_Respawn", (os.time() + respawn))
end
