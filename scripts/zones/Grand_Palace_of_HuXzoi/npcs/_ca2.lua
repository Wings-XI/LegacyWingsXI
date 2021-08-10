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

    if npc:getLocalVar("quasiStatus") == 0 then
        GetNPCByID(16916906):speed(18)
        GetNPCByID(16916906):setPos(796.97, -1, 459.97)
        GetNPCByID(16916906):showText(GetNPCByID(16916906), 7356)
        GetNPCByID(16916906):showNPC(500)
        GetNPCByID(16916906):pathTo(772.07, 0, 460.7) 
        npc:setLocalVar("quasiStatus", 1)
        npc:setLocalVar("checkpoint", 1)
    end

     
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
