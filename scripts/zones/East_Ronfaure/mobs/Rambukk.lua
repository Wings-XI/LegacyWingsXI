-----------------------------------
-- Area: East Ronfaure
--  Mob: Rambukk
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 152)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(900, 3600)) -- 15-60 minutes
end
