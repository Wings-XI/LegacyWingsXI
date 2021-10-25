-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Dagger
-----------------------------------
mixins = {require("scripts/mixins/families/animated_weapons")};
require("scripts/globals/dynamis")
require("scripts/globals/status")
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
-----------------------------------

local zone = 135

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil)
    dynamis.setAnimatedWeaponStats(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end

function onMonsterMagicPrepare(mob, target)
    local warp = mob:getLocalVar("warp")
    local rnd = math.random()
    if warp == 1 then
        return 261 -- warp
    elseif rnd < 0.5 then
        return 186 -- aeroga iii
    elseif rnd < 0.75 then
        return 112 -- flash
    else
        return 226 -- poisonga ii
    end
end

function onMobFight(mob, target)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    DespawnMob(17330306, instance)
    DespawnMob(17330307, instance)
    DespawnMob(17330308, instance)
    DespawnMob(17330316, instance)
    DespawnMob(17330317, instance)
    DespawnMob(17330318, instance)
end
