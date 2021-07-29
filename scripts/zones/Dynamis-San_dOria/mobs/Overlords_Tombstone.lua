-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Overlord's Tombstone
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

local zone = 185

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-San_dOria/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMegaBossStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-San_dOria/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-San_dOria/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    local winQM = GetNPCByID(17535223)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(tpz.status.NORMAL)
    player:addTitle(tpz.title.DYNAMIS_SAN_DORIA_INTERLOPER)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-San_dOria/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end
