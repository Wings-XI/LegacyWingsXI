-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Abquhbah
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local EternalDialogue = player:getLocalVar("TOAU_ETERNAL_DIALOGUE")
    local promotion = player:getCharVar("AssaultPromotion")
    local rank = 0

    if promotion <= 7 then
        rank = 1
    elseif promotion >= 8 and promotion <= 11 then
        rank = 2
    elseif promotion >= 12 and promotion <= 18 then
        rank = 3
    elseif promotion >= 19 and promotion <= 24 then
        rank = 4
    elseif promotion >= 25 then
        rank = 5
    end
    
    if (player:hasCompletedMission(TOAU, tpz.mission.id.toau.ETERNAL_MERCENARY) and EternalDialogue == 0) then
        player:startEvent(3154, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        player:setLocalVar("TOAU_ETERNAL_DIALOGUE", 1)
    else 
        player:startEvent(255, rank)
    end 
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
