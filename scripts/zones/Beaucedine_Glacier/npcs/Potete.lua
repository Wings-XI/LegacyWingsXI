-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Potete
-- Type: NPC
-- !pos 104.907 -21.249 141.391 111
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 10 then
        player:startEvent(213)
    else
        player:startEvent(102)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
