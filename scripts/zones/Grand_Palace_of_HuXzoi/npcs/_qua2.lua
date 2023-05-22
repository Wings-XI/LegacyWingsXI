-----------------------------------
-- Area: Grand Palace
--  NPC: Quasilumin
-- Type: Standard NPC
-- !pos 796.97 -1 459.97 34
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------

local path = 
        {   772.07, 0, 460.7,
            779.99, 0, 441.699,
            780.24, 0, 420.06,
            750.6, 0, 417.98,
            737.54, 0, 411.4,
            725.09, 0, 420.48,
            701.36, 0, 420.28,
            700.17, 0, 438.98,
            699.93, 0, 460.13,
            601.05, 0, 460.05,
            540.02, 0, 460.51,
            539.97, -1, 424.34
        }

function onSpawn(npc)
    npc:initNpcAi()
    npc:speed(18)
    npc:setPos(796.97, -1, 459.97)
    npc:hideNPC(5000)
    local qmNPC = GetNPCByID(16916928)
    qmNPC:setLocalVar("checkpoint", 0)
    qmNPC:setLocalVar("quasiStatus", 0)
    local started = npc:setLocalVar("started", 1)
    local checkpoint = qmNPC:getLocalVar("checkpoint")
    npc:pathTo(772.07, 0, 460.7)
end



function onTrade(player, npc, trade)
end

function onTrigger(player, npc) 
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onPath(npc, player)
    local qmNPC = GetNPCByID(16916928)

    local quasiStatus = qmNPC:getLocalVar("quasiStatus")
    local checkpoint = qmNPC:getLocalVar("checkpoint")

    if checkpoint == 0 and npc:checkDistance(796.97, -1, 459.97) < .1 then
        npc:pathTo(772.07, 0, 460.7)  
        qmNPC:setLocalVar("checkpoint", 1)
    elseif checkpoint == 1 and npc:checkDistance(772.07, 0, 460.7) < .1 then
        npc:pathTo(779.99, 0, 441.699)
        qmNPC:setLocalVar("checkpoint", 2)
    elseif checkpoint == 2 and npc:checkDistance(779.99, 0, 441.699) < .1 then
        npc:pathTo(780.24, 0, 420.06)
        qmNPC:setLocalVar("checkpoint", 3)
    elseif checkpoint == 3 and npc:checkDistance(780.24, 0, 420.06) < .1 then
        npc:pathTo(750.6, 0, 417.98)
        qmNPC:setLocalVar("checkpoint", 4)
    elseif checkpoint == 4 and npc:checkDistance(750.6, 0, 417.98) < .1 then
        npc:pathTo(737.54, 0, 411.4)
        qmNPC:setLocalVar("checkpoint", 5)
    elseif checkpoint == 5 and npc:checkDistance(737.54, 0, 411.4) < .1 then
        npc:pathTo(725.09, 0, 420.48)
        qmNPC:setLocalVar("checkpoint", 6)
    elseif checkpoint == 6 and npc:checkDistance(725.09, 0, 420.48) < .1 then
        npc:pathTo(701.36, 0, 420.28)
        qmNPC:setLocalVar("checkpoint", 7)
    elseif checkpoint == 7 and npc:checkDistance(701.36, 0, 420.28) < .1 then
        npc:pathTo(700.17, 0, 438.98)
        qmNPC:setLocalVar("checkpoint", 8)
    elseif checkpoint == 8 and npc:checkDistance(700.17, 0, 438.98) < .1 then
        if quasiStatus == 1 then
            GetNPCByID(16916872):openDoor(15)
        end
        npc:pathTo(699.93, 0, 460.13)
        qmNPC:setLocalVar("checkpoint", 9)
    elseif checkpoint == 9 and npc:checkDistance(699.93, 0, 460.13) < .1 then
        npc:pathTo(601.05, 0, 460.05)
        qmNPC:setLocalVar("checkpoint", 10)
    elseif checkpoint == 10 and npc:checkDistance(601.05, 0, 460.05) < .1 then
        if quasiStatus == 1 then
            GetNPCByID(16916873):openDoor(15)
        end
        npc:pathTo(540.02, 0, 460.51)
        qmNPC:setLocalVar("checkpoint", 11)
    elseif checkpoint == 11 and npc:checkDistance(540.02, 0, 460.51) < .1 then
        npc:pathTo(539.97, -1, 424.34)
        qmNPC:setLocalVar("checkpoint", 12)
    elseif checkpoint == 12 and npc:checkDistance(539.97, -1, 424.34) < .1 then
        qmNPC:setLocalVar("checkpoint", 0)

        if quasiStatus == 1 then
            GetNPCByID(16916870):openDoor(25)
            qmNPC:setLocalVar("quasiStatus", 0)
            npc:showText(npc, 7358)
            npc:showText(npc, 7361)
        end
        npc:hideNPC(7000)
        npc:setPos(796.97, -1, 459.97)
        npc:pathTo(772.07, 0, 460.7)   
    end

    if quasiStatus == 0 then
        npc:updateNPCHideTime(25000)
    end
end
