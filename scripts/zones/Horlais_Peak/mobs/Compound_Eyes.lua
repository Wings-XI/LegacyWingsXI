-----------------------------------
-- Area: Horlais Peak
--  Mob: Sobbing Eyes
-- BCNM: Under Observation
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    
end

function onMobSpawn(mob)
	mob:addMod(tpz.mod.INT, -10)
	mob:addMod(tpz.mod.REGAIN, 500)
	mob:addMod(tpz.mod.ATTP, -20)
	mob:addMod(tpz.mod.DEFP, -10)
	mob:addMod(tpz.mod.MDEF, -40)	
end

function onMobDeath(mob, player, isKiller)
end
