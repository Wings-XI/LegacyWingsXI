-----------------------------------
-- Area: Pso'Xja
--  NPC: _i95 (Avatar Gate)
-- !pos -360.000 46.353 -220.000 9
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS) == QUEST_ACCEPTED and player:getCharVar("AReputationInRuins_CanComplete") == 0 then
        player:startEvent(7, 0, player:getCharVar("AReputationInRuins_ki"))
    else
        player:messageSpecial(ID.text.DOOR_SHUT)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 7) then
        local keyItem = player:getCharVar("AReputationInRuins_ki")
        player:setCharVar("AReputationInRuins_CanComplete", 1)
        player:messageSpecial(7237, keyItem)
        player:delKeyItem(keyItem)
    end
end
