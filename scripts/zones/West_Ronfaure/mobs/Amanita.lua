------------------------------
-- Area: West Ronfaure
--   NM: Amanita
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 20)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 149)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60-70 minutes
end
