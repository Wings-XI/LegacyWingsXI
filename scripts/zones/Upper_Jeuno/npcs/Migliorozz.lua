-----------------------------------
-- Area: Upper Jeuno
--   NPC: Migliorozz
-- Type: Standard NPC
-- !pos -37.760 -2.499 12.924 244
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
local ID = require("scripts/zones/Upper_Jeuno/IDs")

local possiblekeyItems =
{
    PHOENIX_PEARL = 616,
    PHOENIX_ARMLET = 615
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local questStatus = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS)
    local keyItem = player:getCharVar("AReputationInRuins_ki")
    if keyItem == 0 then
        keyItem = math.random(possiblekeyItems.PHOENIX_PEARL, possiblekeyItems.PHOENIX_ARMLET)
        player:setCharVar("AReputationInRuins_ki", keyItem)
    end

    -- start quest
    if questStatus == QUEST_AVAILABLE then
        player:startEvent(10019, 244, 0, keyItem, 0, 8652052, 1, 4095, 0)

    -- check in during quest
    elseif questStatus == QUEST_ACCEPTED then
        if player:getCharVar("AReputationInRuins_CanComplete") == 1 then
            player:startEvent(10020)
        else
            player:startEvent(10021, 0, keyItem)
        end

    -- quest completed
    elseif questStatus == QUEST_COMPLETED then
        player:startEvent(10022)

    -- default dialog
    else
        player:startEvent(10026)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local keyItem = player:getCharVar("AReputationInRuins_ki")
    -- start quest
    if csid == 10019 and option == 4 then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS)
        if keyItem == possiblekeyItems.PHOENIX_PEARL then
            player:addKeyItem(tpz.ki.PHOENIX_PEARL)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PHOENIX_PEARL)
        else
            player:addKeyItem(tpz.ki.PHOENIX_ARMLET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PHOENIX_ARMLET)
        end
    --completed quest
    elseif csid == 10020 then
        player:setCharVar("AReputationInRuins_CanComplete", 0)
        player:setCharVar("AReputationInRuins_ki", 0)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS)
        player:addGil(3500)
        player:messageSpecial(ID.text.GIL_OBTAINED, 3500)
    end
end
