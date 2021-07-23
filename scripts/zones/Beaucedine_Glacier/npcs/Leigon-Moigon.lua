-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Leigon-Moigon
-- !pos 106.567 -21.249 140.770 111
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 10 then
        player:startEvent(212)
    else
        player:startEvent(103)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end