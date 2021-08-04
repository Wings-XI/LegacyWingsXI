-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Ponderer
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/pathfind")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 5 then
        player:setCharVar("PromathiaStatus", 6)
    end
end

function onMobSpawn(mob)
	mob:delRoamFlag(512)
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
		local point = {math.random(-323, -314), 0, math.random(121, 157)}
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
		local point = {math.random(-323, -314), 0, math.random(121, 157)}
		mob:pathThrough(point, tpz.path.flag.RUN)
	end
end