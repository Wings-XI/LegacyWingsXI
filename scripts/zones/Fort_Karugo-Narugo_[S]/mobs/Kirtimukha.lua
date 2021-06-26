------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Kirtimukha
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 1)
end    

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 523)
end
