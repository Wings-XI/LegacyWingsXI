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
        GetNPCByID(16916904):setPos(-539.9705, -1, 297.24)
        GetNPCByID(16916904):showNPC(1000)
        GetNPCByID(16916904):pathTo(-539.9705, -1, 260.40) 
        npc:setLocalVar("quasiStatus", 1)
        npc:setLocalVar("checkpoint", 1)
        GetNPCByID(16916904):showText(GetNPCByID(16916904), 7356)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
