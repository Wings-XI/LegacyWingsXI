-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Propagator
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("maxBabies", 2)
end

function onMobDeath(mob, player, isKiller)
    local momma = mob:getID()
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
    if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 1 then
        player:setCharVar("PromathiaStatus", 2)
    end
end

function onMobFight(mob, target)
	
	local terrorEndTime = mob:getLocalVar("EmptyTerror")
	if terrorEndTime == 0 then
		return
	elseif terrorEndTime < os.time() then
		mob:setLocalVar("EmptyTerror",0)
		mob:delRoamFlag(512)
		return
	end
	
	-- scripted run around
	mob:addRoamFlag(512) -- ignore attacking
	if not mob:isFollowingPath() then
		mob:disengage()
		local point = {math.random(200, 220), 0, math.random(-70, -60)}
		mob:pathThrough(point, tpz.path.flag.RUN)
	end
end

function onMobRoam(mob)
	local terrorEndTime = mob:getLocalVar("EmptyTerror")
	if terrorEndTime == 0 then
		return
	elseif terrorEndTime < os.time() then
		mob:setLocalVar("EmptyTerror",0)
		mob:delRoamFlag(512)
		return
	end
	
	-- scripted run around
	mob:addRoamFlag(512) -- ignore attacking
	if not mob:isFollowingPath() then
		mob:disengage()
		local point = {math.random(200, 220), 0, math.random(-70, -60)}
		mob:pathThrough(point, tpz.path.flag.RUN)
	end
end