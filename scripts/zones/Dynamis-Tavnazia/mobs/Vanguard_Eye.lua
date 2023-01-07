-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Vanguard Eye
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

local zone = 42

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMobStats(mob)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Tavnazia/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)

    local mobID = mob:getID()
    if mobID == ID.mobs.Eye_Floor1[1] or mobID == ID.mobs.Eye_Floor1[2] then
        -- floor 1 qm3 spawn
        local npc = GetNPCByID(ID.mobs.QM3_Floor1)
        npc:setStatus(tpz.status.NORMAL)
    elseif mobID == ID.mobs.Eye_Floor2[1] or mobID == ID.mobs.Eye_Floor2[2] then
        -- floor 2 qm3 spawn
        local npc = GetNPCByID(ID.mobs.QM3_Floor2)
        npc:setStatus(tpz.status.NORMAL)
    end
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Tavnazia/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end
