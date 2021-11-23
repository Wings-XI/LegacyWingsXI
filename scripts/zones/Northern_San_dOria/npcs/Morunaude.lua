-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Morunaude
--  Involved in Quest: Unexpected Treasure
-- !pos -102.535 -2.262 41.415 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local unexpectedTreasure = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.UNEXPECTED_TREASURE)

    -- Unexpected Treasure - Bring Small teacup to Morunaude to start the quest.
    if unexpectedTreasure == QUEST_AVAILABLE and player:hasKeyItem(tpz.keyItem.SMALL_TEACUP) then
        player:startEvent(635, 0, 160, 57)
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.UNEXPECTED_TREASURE)
        player:setCharVar("UnexpectedTreasure", 1)
    elseif unexpectedTreasure == QUEST_ACCEPTED then 
        player:startEvent(636, 0, 0, 57)
        player:setCharVar("UnexpectedTreasure", 2)
    else
        player:startEvent(634)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
