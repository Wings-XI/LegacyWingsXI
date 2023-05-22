-----------------------------------
-- Area: Grand Palace
--  NPC: Cermet Alcove #2
-- Type: Standard NPC
-- !pos 796.97 -1 459.97 34
-----------------------------------
require("scripts/globals/pathfind")
----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local quasiNPC = GetNPCByID(16916906)
    local quasiStatus = npc:getLocalVar("quasiStatus")

    if npc:getLocalVar("quasiStatus") == 0 then
        quasiNPC:speed(20)
        quasiNPC:setPos(796.97, -1, 459.97)
        quasiNPC:showText(quasiNPC, 7356)
        quasiNPC:showNPC(500)
        quasiNPC:pathTo(772.07, 0, 460.7)
        npc:setLocalVar("quasiStatus", 1)
        npc:setLocalVar("checkpoint", 1)
    end

     
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
