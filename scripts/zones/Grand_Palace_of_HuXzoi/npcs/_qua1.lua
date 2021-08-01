-----------------------------------
-- Area: Garden
--  NPC: Quasilumin
-- Type: Standard NPC
-- !pos -27.443 -1 -636.850 33
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_Huxzoi/IDs")
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
    npc:setPos(tpz.path.first(path))
    npc:speed(25)
    onPath(npc)
    npc:hideNPC()
    local started = npc:setLocalVar("started", 1)
end


function onTrade(player, npc, trade)
end

function onTrigger(player, npc) 

    started = npc:getLocalVar("started")

    if started == 1 then
        npc:wait(5000)
        print("stop")
        player:showText(npc, 7365)
        npc:setLocalVar("started", 0)
    else
        npc:initNpcAi()
		npc:pathTo(-260.0403, -1, 496.08862)
        print("start")
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

    if npc:checkDistance(-260.22, -1, 497.0349) < 5 then
        npc:speed(15)
    end

    if npc:checkDistance(-260.0403, -1, 496.08862) < 0.5 and quasiStatus == 1  then
        GetNPCByID(16916869):openDoor(15)
        npc:hideNPC(7000)
        npc:initNpcAi()
        npc:setPos(tpz.path.first(path))
        onPath(npc)
        print(quasiStatus)
        --player:showText(npc, 7358)
        --player:showText(npc, 7361)
        print("success")
        GetNPCByID(16916927):setLocalVar("quasiStatus", 0)         
    elseif npc:checkDistance(-260.0403, -1, 496.08862) < 0.5 then
        npc:initNpcAi()
        npc:setPos(tpz.path.first(path))
        onPath(npc)
    end


    if quasiStatus == 0 then
        npc:updateNPCHideTime(500)
        --print(quasiStatus)
    end



    tpz.path.patrol(npc, path)

end