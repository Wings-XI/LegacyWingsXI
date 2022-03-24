------------------------------
-- Area: Oldton Movalpolos
--   NM: Bugbear Muscleman
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGAIN, 500)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 246)
end

function onMobDespawn(mob)
    local respawn = 5700
    mob:setRespawnTime(respawn) -- 95 minutes
    SetServerVariable("Bugbear_Muscleman_Respawn", (os.time() + respawn))
end
