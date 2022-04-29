-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Goblin Replica
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/zones/Dynamis-Jeuno/dynamis_mobs")
local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
-----------------------------------

local zone = 188

function onMobSpawn(mob)
    if mob:getID() == 17547957 then mob:speed(0) end -- statue 293 cannot be pulled out of palace
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setStatueStats(mob)
end

function onMobDeath(mob, player, isKiller)
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)    
    local mobID = mob:getID()
    local patrolPath = nil
    if mobList[zone][mobID].patrolPath ~= nil then
        patrolPath = mobList[zone][mobID].patrolPath
    end

    if mob:isFollowingPath() == false then
        if patrolPath ~= nil then
            mob:pathThrough(tpz.path.first(patrolPath))
        else
            dynamis.mobOnRoam(mob, mobList[zone])
        end
    end
end

function onPath(mob)
    local mobID = mob:getID()
    local patrolPath = nil
    if mobList[zone][mobID].patrolPath ~= nil then
        patrolPath = mobList[zone][mobID].patrolPath
    end
    if patrolPath ~= nil then
        tpz.path.patrol(mob, patrolPath)
    end
end

function onMobEngaged(mob, target)
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end

function onMobFight(mob, target)
    dynamis.onStatueFight(mob, target)
end

function onMobSkillFinished(mob, target, skill)
    dynamis.onStatueSkillFinished(mob, target, skill)
end