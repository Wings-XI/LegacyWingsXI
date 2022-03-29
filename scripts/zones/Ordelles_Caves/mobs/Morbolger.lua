-----------------------------------
-- Area: Ordelles Caves (193)
--   NM: Morbolger
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1) -- "Aggros regardless of level"
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.MORBOLBANE)
end

function onMobDespawn(mob)
    local respawn = math.random(75600, 86400) -- 21 to 24 hours
    mob:setRespawnTime(respawn) -- 21 hrs then 10 min windows
    SetServerVariable("Morbolger_Respawn", (os.time() + respawn))
    UpdateNMSpawnPoint(mob:getID())
end
