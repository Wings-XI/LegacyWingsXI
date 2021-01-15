-----------------------------------
-- Area: Riverne - Site B01
--  Mob: Unstable Cluster
--  !gotoid 16896155
-----------------------------------

require("scripts/globals/status")

function onMobSpawn(mob)
	mob:setMod(tpz.mod.TRIPLE_ATTACK,100) -- temporary until mixins are done for clusters (he should get 1 attack per remaining bomb)
end

function onMobDeath(mob, player, isKiller)
	
end
