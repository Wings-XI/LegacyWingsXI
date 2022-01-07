-----------------------------------
-- Area: East Ronfaure
--  NPC: Andelain
-- Type: Standard NPC
-- !pos 664.231 -12.849 -539.413 101
--  Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    sermonQuest = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_VICASQUE_S_SERMON)

    if (sermonQuest == QUEST_ACCEPTED) then
        count = trade:getItemCount()
        BluePeas = trade:getItemQty(618)
        if (BluePeas == 1 and count == 1 and player:getCharVar("sermonQuestVar") == 0) then
            player:tradeComplete()
            player:showText(npc, 7414)
            player:startEvent(19)
            player:showText(npc, 7416)
            player:setCharVar("sermonQuestVar", 1)
        elseif (BluePeas > 1 and count == BluePeas) then
            player:showText(npc, 7417, 618)
        else
            player:showText(npc, 7415, 618)
        end
    elseif (sermonQuest == QUEST_COMPLETED) then    
        player:showText(npc, 7417)
    end
end

function onTrigger(player, npc)
    sermonQuest = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_VICASQUE_S_SERMON)

    if sermonQuest == QUEST_ACCEPTED and player:getCharVar("sermonQuestVar") == 0 then
        player:showText(npc, 7413, 618)    
    elseif player:getCharVar("sermonQuestVar") >= 1 then 
        player:startEvent(19)
        player:showText(npc, 7416)
    else
        player:showText(npc, 7412)
        player:showText(npc, 7416)
        player:startEvent(19)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
