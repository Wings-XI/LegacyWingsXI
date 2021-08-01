-----------------------------------
-- Area: Al'Taieu
--  NPC: Cermet Alcove #2 
-- Type: Standard NPC
-- !pos -260.000 -1.000 422.500 33
-----------------------------------
require("scripts/globals/pathfind")
----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local quasiStatus = npc:getLocalVar("quasiStatus")

    print(quasiStatus)

    if npc:getLocalVar("quasiStatus") == 0 then
       
        GetNPCByID(16916906):setPos(796.97, -1, 459.97)
        GetNPCByID(16916906):showNPC(1000)
        GetNPCByID(16916906):showText(npc, 7356)
        GetNPCByID(16916906):speed(20)
        GetNPCByID(16916906):pathTo(779.99, 0, 441.699)
        npc:setLocalVar("checkpoint", 2)
        npc:setLocalVar("quasiStatus", 1)
    end

    print(quasiStatus)


     
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
