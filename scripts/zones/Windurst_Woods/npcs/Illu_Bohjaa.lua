-----------------------------------
-- Area: Windurst Woods
--  NPC: Illu Bohjaa
-- Involved in the repeatable quest "Creepy Crawlies"
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local qStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CREEPY_CRAWLIES)
    if qStatus ~= QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, {{816, 3}}) then -- silk thread x3
            player:addFame(WINDURST, 15)
            player:startEvent(335, 600 * GIL_RATE, 816, 938, 1156)
            if qStatus == QUEST_ACCEPTED then player:completeQuest(WINDURST, tpz.quest.id.windurst.CREEPY_CRAWLIES) end
        elseif npcUtil.tradeHas(trade, {{1156, 3}}) then -- crawler calculus x3
            player:addFame(WINDURST, 30)
            player:startEvent(335, 600 * GIL_RATE, 816, 938, 1156)
            if qStatus == QUEST_ACCEPTED then player:completeQuest(WINDURST, tpz.quest.id.windurst.CREEPY_CRAWLIES) end
        end
    end
end

function onTrigger(player, npc)
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CREEPY_CRAWLIES) == QUEST_AVAILABLE then
        player:startEvent(333, 0, 816, 938, 1156)
    else
        player:startEvent(334, 0, 816, 938, 1156)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 333 and option == 1 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.CREEPY_CRAWLIES)
    elseif csid == 335 then
        local hideMessage = true
        if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.CREEPY_CRAWLIES) == QUEST_AVAILABLE then
            npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.CREEPY_CRAWLIES, {fame=0, title=tpz.title.CRAWLER_CULLER})
            npcUtil.giveCurrency(player, "gil", 600, hideMessage)
        else
            npcUtil.giveCurrency(player, "gil", 600, hideMessage)
        end
        player:confirmTrade()
    end
end
