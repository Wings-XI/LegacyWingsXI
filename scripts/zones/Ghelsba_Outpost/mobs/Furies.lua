-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Furies
-- BCNM: Wings of Fury
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMobDeath(mob, player, isKiller)
end

-- if you aggro either furies, it will force aggro previous id (other furies) or on colo-colo, 
-- which in turn aggros the rest of the bcnm mobs

function onMobEngaged(mob, target)
    local mobID = mob:getID()
    local m = GetMobByID(mobID - 1)
	if m and m:isSpawned() and m:isAlive() then
		m:updateEnmity(target)
	end
end
