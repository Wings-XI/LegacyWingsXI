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
        {   -260, -1.5, 423.5,
            -259.98, 0, 442.4651, 
            -260.2, 0, 442.45,                  
            -259.92, 0, 452.76,
            -259.96, 0, 464.63,
            -259.96, 0, 474.12,
            -259.96, 0, 482.75,
            -259.96, 0, 488.338,
            -260.1, 0, 493.63,
            -260.0403, -1, 496.08862,
        }

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(-260, -1.5, 423.5)
    npc:speed(18)
    npc:hideNPC(5000)
    GetNPCByID(16916928):setLocalVar("quasiStatus", 0)
    local started = npc:setLocalVar("started", 1)
    npc:pathTo(-260.0403, -1, 496.08862)
end


function onTrade(player, npc, trade)
end

function onTrigger(player, npc) 

    started = npc:getLocalVar("started")

    if started == 1 then
        npc:wait(5000)
        player:showText(npc, 7365)
        npc:setLocalVar("started", 0)
    else
        npc:initNpcAi()
		npc:pathTo(-260.0403, -1, 496.08862)
        player:showText(npc, 7366)
        npc:setLocalVar("started", 1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

function onPath(npc, player)

    local quasiStatus = GetNPCByID(16916927):getLocalVar("quasiStatus")

    if npc:checkDistance(-260.0403, -1, 496.08862) == 0 then

        if quasiStatus == 1 then
            npc:showText(npc, 7358)
            npc:showText(npc, 7361)
            GetNPCByID(16916869):openDoor(25)
            GetNPCByID(16916927):setLocalVar("quasiStatus", 0) 
        end
        npc:hideNPC(7000)
        npc:setPos(-260, -1.5, 423.5)
        npc:pathTo(-260.0403, -1, 496.08862)   
    end


    if quasiStatus == 0 then
        npc:updateNPCHideTime(25000)
    end
end
