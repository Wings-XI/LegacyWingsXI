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
        GetNPCByID(16916905):speed(20)
        GetNPCByID(16916905):setPos(540, -1, 296.5)
        GetNPCByID(16916905):showText(GetNPCByID(16916905), 7356)
        GetNPCByID(16916905):showNPC(500)
        GetNPCByID(16916905):pathTo(539.95, 0, 260.12) 
        npc:setLocalVar("quasiStatus", 1)
        npc:setLocalVar("checkpoint", 1)
    end
     
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
