-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Fly
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zoneID = tpz.zone.DYNAMIS_VALKURM
local zone = zones[tpz.zone.DYNAMIS_VALKURM]

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zoneID][mobID] ~= nil and mobList[zoneID][mobID].eyes or 0)
    dynamis.setMobStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Valkurm/IDs")
    local sjQM = GetNPCByID(zone.mobs.sjRestrictionNPC)
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zoneID], ID.text.DYNAMIS_TIME_EXTEND)
    local deadFlies = 0
    if GetMobByID(zone.mobs.Nightmare_Fly_1):isDead() then
        deadFlies = deadFlies + 1
    end
    if GetMobByID(zone.mobs.Nightmare_Fly_2):isDead() then
        deadFlies = deadFlies + 1
    end
    if GetMobByID(zone.mobs.Nightmare_Fly_3):isDead() then
        deadFlies = deadFlies + 1
    end
    if deadFlies > 2 then
        SetServerVariable(string.format("DynamisSJRestriction_%s", zoneID), 1)
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
    if mobList[zoneID][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zoneID][mobList[zoneID][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zoneID], randomChildrenListArg)
end
