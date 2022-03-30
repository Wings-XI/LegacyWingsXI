-----------------------------------
-- Area: East Ronfaure [S]
--   NM: Melusine
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 482)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = 7200 + math.random(0, 20) * 60
    mob:setRespawnTime(respawn) -- 2h to 2h 20m
    SetServerVariable("Melusine_Respawn", (os.time() + respawn))
end
