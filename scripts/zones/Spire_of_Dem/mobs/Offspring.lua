-----------------------------------
-- Area: Spire of Dem
--  Mob: Progenerator
-----------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    local id = mob:getID()
	local mommy = nil
	local battlefield = nil
	
	if id < 16855046 then mommy = GetMobByID(16855041)
	elseif id < 16855051 then mommy = GetMobByID(16855046)
	else mommy = GetMobByID(16855051) end
	
	if mommy ~= nil then battlefield = mommy:getBattlefield() end
	if battlefield ~= nil then battlefield:insertEntity(mob,false,true,0) end
end

function onMobEngaged(mob,target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobFight(mob,target)
end

function onMobDeath(mob, player, isKiller)
end
