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

    print(checker)

    if npc:getLocalVar("quasiStatus") == 0 then
        player:showText(npc, 7356)
        GetNPCByID(16916926):setPos(-260, -1.5, 422.5)
        GetNPCByID(16916926):showNPC(500)
        GetNPCByID(16916926):speed(25)
        npc:setLocalVar("quasiStatus", 1)
    end

    print(quasiStatus)


     
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
