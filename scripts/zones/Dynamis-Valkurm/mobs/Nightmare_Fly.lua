-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Fly
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39
local zoneID = zones[zone]

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMobStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Valkurm/IDs")
    local sjQM = GetNPCByID(zoneID.mobs.sjRestrictionNPC)
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    local deadFlies = 0
    if GetMobByID(zoneID.mobs.Nightmare_Fly_2):isDead() then
        deadFlies = deadFlies + 1
    end
    if GetMobByID(zoneID.mobs.Nightmare_Fly_3):isDead() then
        deadFlies = deadFlies + 1
    end
    if GetMobByID(zoneID.mobs.Nightmare_Fly_2):isDead() then
        deadFlies = deadFlies + 1
    end
    if deadFlies > 2 then
        SetServerVariable(string.format("DynamisSJRestriction_%s", zoneId), 1)
        dynamis.sjQMOnTrigger(sjQM, sjQM)
    end

end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end
