-----------------------------------
-- Area: Garden
--  NPC: Quasilumin
-- Type: Standard NPC
-- !pos -27.443 -1 -636.850 33
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
    GetNPCByID(16916928):setLocalVar("checkpoint", 0) 
    GetNPCByID(16916928):setLocalVar("quasiStatus", 0)
    local started = npc:setLocalVar("started", 1)
    local checkpoint = GetNPCByID(16916928):getLocalVar("checkpoint")
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

    local quasiStatus = GetNPCByID(16916928):getLocalVar("quasiStatus")
    local checkpoint = GetNPCByID(16916928):getLocalVar("checkpoint")

    if checkpoint == 0 and npc:checkDistance(796.97, -1, 459.97) == 0 then
        npc:pathTo(772.07, 0, 460.7)  
        GetNPCByID(16916928):setLocalVar("checkpoint", 1)
    elseif checkpoint == 1 and npc:checkDistance(772.07, 0, 460.7) == 0 then
        npc:pathTo(779.99, 0, 441.699)
        GetNPCByID(16916928):setLocalVar("checkpoint", 2)
    elseif checkpoint == 2 and npc:checkDistance(779.99, 0, 441.699) == 0 then
        npc:pathTo(780.24, 0, 420.06)
        GetNPCByID(16916928):setLocalVar("checkpoint", 3)
    elseif checkpoint == 3 and npc:checkDistance(780.24, 0, 420.06) == 0 then
        npc:pathTo(750.6, 0, 417.98)
        GetNPCByID(16916928):setLocalVar("checkpoint", 4)
    elseif checkpoint == 4 and npc:checkDistance(750.6, 0, 417.98) == 0 then
        npc:pathTo(737.54, 0, 411.4)
        GetNPCByID(16916928):setLocalVar("checkpoint", 5)
    elseif checkpoint == 5 and npc:checkDistance(737.54, 0, 411.4) == 0 then
        npc:pathTo(725.09, 0, 420.48)
        GetNPCByID(16916928):setLocalVar("checkpoint", 6)
    elseif checkpoint == 6 and npc:checkDistance(725.09, 0, 420.48) == 0 then
        npc:pathTo(701.36, 0, 420.28)
        GetNPCByID(16916928):setLocalVar("checkpoint", 7)
    elseif checkpoint == 7 and npc:checkDistance(701.36, 0, 420.28) == 0 then
        npc:pathTo(700.17, 0, 438.98)
        GetNPCByID(16916928):setLocalVar("checkpoint", 8)
    elseif checkpoint == 8 and npc:checkDistance(700.17, 0, 438.98) == 0 then
        if quasiStatus == 1 then
            GetNPCByID(16916872):openDoor(15)
        end
        npc:pathTo(699.93, 0, 460.13)
        GetNPCByID(16916928):setLocalVar("checkpoint", 9)
    elseif checkpoint == 9 and npc:checkDistance(699.93, 0, 460.13) == 0 then
        npc:pathTo(601.05, 0, 460.05)
        GetNPCByID(16916928):setLocalVar("checkpoint", 10)
    elseif checkpoint == 10 and npc:checkDistance(601.05, 0, 460.05) == 0 then
        if quasiStatus == 1 then
            GetNPCByID(16916873):openDoor(15)
        end
        npc:pathTo(540.02, 0, 460.51)
        GetNPCByID(16916928):setLocalVar("checkpoint", 11)
    elseif checkpoint == 11 and npc:checkDistance(540.02, 0, 460.51) == 0 then
        npc:pathTo(539.97, -1, 424.34)
        GetNPCByID(16916928):setLocalVar("checkpoint", 12)
    elseif checkpoint == 12 and npc:checkDistance(539.97, -1, 424.34) == 0 then
        GetNPCByID(16916928):setLocalVar("checkpoint", 0)

        if quasiStatus == 1 then
            GetNPCByID(16916870):openDoor(25)
            GetNPCByID(16916928):setLocalVar("quasiStatus", 0) 
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
