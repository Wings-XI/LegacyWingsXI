-----------------------------------
-- Area: Uleguerand Range
-- NPC: Buffalostalker Dodzbraz
-- Type: Quest NPC
-- !pos -380.171 -24.89 -180.797 5
-----------------------------------

require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local bombsaway = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.BOMBS_AWAY)

    if bombsaway == QUEST_ACCEPTED and npcUtil.tradeHas(trade, {{1667, 2}}) then -- 2x Cluster Core
        player:startEvent(8)
    elseif bombsaway == QUEST_COMPLETED and npcUtil.tradeHas(trade, {{1667, 2}}) then -- 2x Cluster Core
        player:startEvent(8)
    end
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.THREE_PATHS or player:hasCompletedMission(COP, tpz.mission.id.cop.THREE_PATHS) then
        local bombsaway = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.BOMBS_AWAY)

        if bombsaway == QUEST_AVAILABLE then
            player:startEvent(6)
        elseif bombsaway == QUEST_ACCEPTED then
            player:startEvent(7)
        elseif bombsaway == QUEST_COMPLETED then
            player:startEvent(7)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 6 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.BOMBS_AWAY)
    elseif csid == 8 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.BOMBS_AWAY, {item = 5267}) then -- shumeyo salt
        player:confirmTrade()
    elseif csid == 8 and npcUtil.giveItem(player, 5267) then -- shumeyo salt
        player:confirmTrade()
    end
end
