-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Furies
-- BCNM: Wings of Fury
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 18)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 80)
    mob:setMobMod(tpz.mobMod.MAGIC_DELAY, 7)
end

-- if you aggro either furies, it will force aggro previous id (other furies) or on colo-colo, 
-- which in turn aggros the rest of the bcnm mobs

function onMobEngaged(mob, target)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)

    local mobID = mob:getID()
    local m = GetMobByID(mobID - 1)
	if m and m:isSpawned() and m:isAlive() then
		m:updateEnmity(target)
	end
end

function onMobFight(mob, target)
    if target:isMob() or mob:getHPP() == 100 then
        mob:SetMagicCastingEnabled(false)
    else
        mob:SetMagicCastingEnabled(true)
    end
end

function onMobDeath(mob, player, isKiller)
end