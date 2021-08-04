-----------------------------------
-- Area: Al'Taieu
--  NPC: Cermet Alcove #1 
-- Type: Standard NPC
-- !pos -260.000 -1.000 422.500 33
-----------------------------------



function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local quasiStatus = npc:getLocalVar("quasiStatus")

    if npc:getLocalVar("quasiStatus") == 0 then
        GetNPCByID(16916926):showText(GetNPCByID(16916926), 7356)
        GetNPCByID(16916926):setPos(-260, -1.5, 422.5)
        GetNPCByID(16916926):showNPC(500)
        GetNPCByID(16916926):speed(20)
        GetNPCByID(16916926):pathTo(-260.0403, -1, 496.08862) 
        npc:setLocalVar("quasiStatus", 1)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
