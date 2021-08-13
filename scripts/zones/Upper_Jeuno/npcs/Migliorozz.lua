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
    local keyItem = player:getCharVar("QuestAReputationInRuins_ki")
    if keyItem == 0 then
        keyItem = math.random(possiblekeyItems.PHOENIX_PEARL, possiblekeyItems.PHOENIX_ARMLET)
        player:setCharVar("QuestAReputationInRuins_ki", keyItem)
    end

    -- start quest
    if questStatus == QUEST_AVAILABLE then
        player:startEvent(10019, 244, 0, keyItem, 0, 8652052, 1, 4095, 0)

    -- check in during quest
    elseif questStatus == QUEST_ACCEPTED then
        player:startEvent(10021, 0, keyItem)

    -- default dialog
    else
        player:startEvent(10026)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- start quest
    if csid == 10019 and option == 4 then
        local keyItem = player:getCharVar("QuestAReputationInRuins_ki")
        player:addQuest(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS)
        if keyItem == possiblekeyItems.PHOENIX_PEARL then
            player:addKeyItem(tpz.ki.PHOENIX_PEARL)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PHOENIX_PEARL)
        else
            player:addKeyItem(tpz.ki.PHOENIX_ARMLET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PHOENIX_ARMLET)
        end
    end
end
