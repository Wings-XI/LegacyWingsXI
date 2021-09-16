-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Knuckles
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
    elseif not mob:hasStatusEffect(tpz.effect.PROTECT) and rnd < 0.25 then
        return 128 -- protectra iv
    elseif not mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) and rnd < 0.50 then
        return 249 -- blaze spikes
    else
        return 358 -- hastega
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
    DespawnMob(17330309, instance)
    DespawnMob(17330310, instance)
    DespawnMob(17330311, instance)
    DespawnMob(17330319, instance)
    DespawnMob(17330320, instance)
    DespawnMob(17330321, instance)
end
