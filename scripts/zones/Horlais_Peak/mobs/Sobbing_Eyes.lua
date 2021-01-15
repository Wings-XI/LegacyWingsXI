-----------------------------------
-- Area: Horlais Peak
--  Mob: Sobbing Eyes
-- BCNM: Under Observation
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 40)
end

function onMobSpawn(mob)
	mob:addMod(tpz.mod.INT, -6)
	mob:addMod(tpz.mod.ATTP, -10)
	mob:addMod(tpz.mod.DEFP, -10)
	mob:addMod(tpz.mod.MDEF, -40)
end

function onMobDeath(mob, player, isKiller)
end
