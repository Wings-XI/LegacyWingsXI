-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Hammer
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
    if warp == 1 then
        return 261 -- warp
    elseif not mob:hasStatusEffect(tpz.effect.PHALANX) then
        return 106 -- phalanx
    else
        return 21 -- holy
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
    DespawnMob(17330334, instance)
    DespawnMob(17330335, instance)
    DespawnMob(17330336, instance)
    DespawnMob(17330344, instance)
    DespawnMob(17330345, instance)
    DespawnMob(17330346, instance)
end
