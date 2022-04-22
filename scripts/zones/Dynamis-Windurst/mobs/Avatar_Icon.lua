-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Avatar Icon
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

local zone = 187

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Windurst/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setStatueStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Windurst/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Windurst/IDs")
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
    require("scripts/zones/Dynamis-Windurst/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end

function onMobFight(mob, target)
    if mob:getHP() == 1 then
        mob:setTP(0)
        if mob:AnimationSub() == 2 then
            mob:useMobAbility(1124)
        elseif mob:AnimationSub() == 3 then
            mob:useMobAbility(1125)
        end
    end
end

function onMobSkillFinished(mob, target, skill)
    if skill:getID() == 1124 or skill:getID() == 1125 then
        mob:setUnkillable(false)
        mob:setHP(0)
    end
end