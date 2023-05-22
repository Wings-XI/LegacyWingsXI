-----------------------------------
-- Area: Grand Palace
--  NPC: Cermet Alcove #1 
-- Type: Standard NPC
-- !pos -260 -1.5 423.5 34
-----------------------------------



function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local quasiNPC = GetNPCByID(16916926)
    local quasiStatus = npc:getLocalVar("quasiStatus")

    if npc:getLocalVar("quasiStatus") == 0 then
        quasiNPC:speed(20)
        quasiNPC:setPos(-260, -1.5, 422.5)
        quasiNPC:showText(quasiNPC, 7356)
        quasiNPC:showNPC(500)
        quasiNPC:pathTo(-260.0403, -1, 496.08862)
        npc:setLocalVar("quasiStatus", 1)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
