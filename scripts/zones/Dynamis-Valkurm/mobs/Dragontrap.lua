-----------------------------------
-- Area: Dynamis - Valkrum
--  Mob: Dragontrap
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setNMStats(mob)
    -- Set Mods
    mob:addMod(tpz.mod.REGAIN, 1250)
    mob:SetAutoAttackEnabled(false)

    if mob:getID() == 16937576 then
        mob:setMod(tpz.mod.SLEEPRES, 100)
        mob:setMod(tpz.mod.LULLABYRES, 100)
        mob:setMod(tpz.mod.FIRERES, 0)
        mob:setMod(tpz.mod.ICERES, 0)
        mob:setMod(tpz.mod.WATERERES, 0)
        mob:setMod(tpz.mod.THUNDERRES, 0)
        mob:setMod(tpz.mod.EARTHRES, 0)
        mob:setMod(tpz.mod.WINDRES, 0)
        mob:setMod(tpz.mod.LIGHTRES, 0)
        mob:setMod(tpz.mod.DARKRES, 0)
    else
        mob:setMod(tpz.mod.SLEEPRES, 40)
        mob:setMod(tpz.mod.LULLABYRES, 40)
        mob:setMod(tpz.mod.FIRERES, 100)
        mob:setMod(tpz.mod.ICERES, 100)
        mob:setMod(tpz.mod.WATERERES, 100)
        mob:setMod(tpz.mod.THUNDERRES, 100)
        mob:setMod(tpz.mod.EARTHRES, 100)
        mob:setMod(tpz.mod.WINDRES, 100)
        mob:setMod(tpz.mod.LIGHTRES, 99)
        mob:setMod(tpz.mod.DARKRES, 99)
    end
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Valkurm/IDs")
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
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end