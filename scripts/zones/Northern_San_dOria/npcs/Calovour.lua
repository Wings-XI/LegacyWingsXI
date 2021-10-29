-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Calovour
--  Involved in Quest: Unexpected Treasure
-- !pos 131.913 0.000 129.422 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local unexpectedTreasure = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.UNEXPECTED_TREASURE)

    if unexpectedTreasure == QUEST_ACCEPTED and player:getCharVar("UnexpectedTreasure") == 3 then
        if (trade:hasItemQty(918, 1) and trade:getItemCount() == 1) then -- Trade Mistletoe to Calovour.
            player:startEvent(639, 0, 0, 0, 918)
        end
    end
end

function onTrigger(player, npc)
    local unexpectedTreasure = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.UNEXPECTED_TREASURE)

    -- Unexpected Treasure Quest dialogue
    if unexpectedTreasure == QUEST_ACCEPTED and player:hasKeyItem(tpz.keyItem.SMALL_TEACUP) and player:getCharVar("UnexpectedTreasure") == 2 then
        player:startEvent(637, 0, 0, 57, 918)
        player:setCharVar("UnexpectedTreasure", 3)
    elseif player:getCharVar("UnexpectedTreasure") == 3 then
        player:startEvent(638, 0, 0, 57, 918)
    else
        player:startEvent(633)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- Unexpected Treasure Quest Reward
    if (csid == 639) then
        player:tradeComplete()
        player:addGil(GIL_RATE*12000)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*12000)
        player:addFame(SANDORIA, 30)
        player:setCharVar("UnexpectedTreasure", 0)
        player:setCharVar("CupboardPlaced", 0)
        player:delKeyItem(tpz.keyItem.SMALL_TEACUP)
        player:completeQuest(SANDORIA, tpz.quest.id.sandoria.UNEXPECTED_TREASURE)
    end 
end
