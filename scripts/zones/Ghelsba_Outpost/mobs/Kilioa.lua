-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Kilioa
-- BCNM: Petrifying Pair
-----------------------------------

function onMobEngaged(mob, target)
    local mobID = mob:getID() -- Link with other lizard on aggro.
    local Kalamainu = GetMobByID(mobID - 1)
	if Kalamainu:isSpawned() and Kalamainu:isAlive() then
		Kalamainu:updateEnmity(target)
	end

    mob:useMobAbility(373) -- Mobs use Secretion upon engage.
	mob:setMod(tpz.mod.DELAY, 1750) -- Increased attack speed per wiki.
end

function onMobWeaponSkillPrepare(mob, target)
	local rnd = math.random() -- Per wiki, mobs in Petrifying Pair heavily favor Baleful Gaze.
	
	if rnd > 0.4 then
	return 370
	end	
end

function onMobDeath(mob, player, isKiller)
end
