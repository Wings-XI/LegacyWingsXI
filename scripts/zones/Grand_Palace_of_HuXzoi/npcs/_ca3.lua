-----------------------------------
-- Area: Grand Palace
--  NPC: Cermet Alcove #3
-- Type: Standard NPC
-- !pos 540 -1 296.5 34
-----------------------------------
require("scripts/globals/pathfind")
----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local quasiNPC = GetNPCByID(16916905)
    local quasiStatus = npc:getLocalVar("quasiStatus")

    if npc:getLocalVar("quasiStatus") == 0 then
        quasiNPC:speed(20)
        quasiNPC:setPos(540, -1, 296.5)
        quasiNPC:showText(quasiNPC, 7356)
        quasiNPC:showNPC(500)
        quasiNPC:pathTo(539.95, 0, 260.12)
        npc:setLocalVar("quasiStatus", 1)
        npc:setLocalVar("checkpoint", 1)
    end
     
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
