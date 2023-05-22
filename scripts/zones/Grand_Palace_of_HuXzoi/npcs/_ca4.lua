-----------------------------------
-- Area: Grand Palace
--  NPC: Cermet Alcove #4
-- Type: Standard NPC
-- !pos -539.9705 -1 297.24 34
-----------------------------------
require("scripts/globals/pathfind")
----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local quasiNPC = GetNPCByID(16916904)
    local quasiStatus = npc:getLocalVar("quasiStatus")

    if npc:getLocalVar("quasiStatus") == 0 then
        quasiNPC:speed(20)
        quasiNPC:setPos(-539.9705, -1, 297.24)
        quasiNPC:showText(quasiNPC, 7356)
        quasiNPC:showNPC(500)
        quasiNPC:pathTo(-539.9705, -1, 260.40)
        npc:setLocalVar("quasiStatus", 1)
        npc:setLocalVar("checkpoint", 1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
