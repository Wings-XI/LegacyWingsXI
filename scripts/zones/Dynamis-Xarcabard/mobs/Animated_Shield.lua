-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Animated Shield
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
    mob:setMod(tpz.mod.SHIELD_BASH, 8) -- Sets a dmg multiplier for shield bash
    mob:setMod(tpz.mod.DMGMAGIC, -50)
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
    elseif not mob:hasStatusEffect(tpz.effect.PHALANX) and rnd < 0.25 then
        return 106 -- phalanx
    elseif rnd < 0.5 then
        return 9 -- curaga III
    elseif not mob:hasStatusEffect(tpz.effect.PROTECT) and rnd < 0.75 then
        return 46 -- protect iv
    else
        return 273 -- sleepga
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
    DespawnMob(17330290, instance)
    DespawnMob(17330291, instance)
    DespawnMob(17330292, instance)
    DespawnMob(17330299, instance)
    DespawnMob(17330300, instance)
    DespawnMob(17330301, instance)
end
