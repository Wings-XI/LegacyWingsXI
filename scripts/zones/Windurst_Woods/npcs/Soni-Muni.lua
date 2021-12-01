-----------------------------------
-- Area: Windurst Woods
--  NPC: Soni-Muni
-- Starts & Finishes Quest: The Amazin' Scorpio
-- !pos -17.073 1.749 -59.327 241
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.366, 1.750, -59.804,
    -18.176, 1.750, -59.733,
    -17.620, 1.750, -59.529,
    -16.961, 1.750, -59.286,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.590, 1.750, -59.149,
    -16.961, 1.750, -59.286,
    -17.620, 1.750, -59.529,
    -18.176, 1.750, -59.733,
    -18.303, 1.750, -59.925,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player, npc, trade)
    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 1017) then
        player:startEvent(484)
    end
end

function onTrigger(player, npc)
    local amazinScorpio = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO)
    local wildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(wildcatWindurst, 0) then
        player:startEvent(735)
    elseif amazinScorpio == QUEST_COMPLETED then
        player:startEvent(485)
    elseif amazinScorpio == QUEST_ACCEPTED then
        player:startEvent(482, 0, 0, 1017)
    elseif amazinScorpio == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 2 then
        player:startEvent(481, 0, 0, 1017)
    else
        player:startEvent(421)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 481 then
        player:addQuest(WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO)
    elseif csid == 484 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.THE_AMAZIN_SCORPIO, {fame=80, title=tpz.title.GREAT_GRAPPLER_SCORPIO, gil=1500}) then
        player:confirmTrade()
    elseif csid == 735 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 0, true))
    end
end
