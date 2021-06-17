------------------------------
-- Area: Grauberg [S]
--   NM: Vasiliceratops
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
	mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 505)
end
