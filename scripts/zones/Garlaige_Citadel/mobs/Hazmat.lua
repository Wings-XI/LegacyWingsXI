------------------------------
-- Area: Garlaige Citadel
--   NM: Hazmat
------------------------------
require("scripts/globals/status")
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.FASTCAST,50)
    mob:setMod(tpz.mod.REFRESH,20)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 300)
end
