-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Adamantking Effigy
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

local zone = 135

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end

function onMobFight(mob, target)
    if mob:getHP() == 1 then
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
