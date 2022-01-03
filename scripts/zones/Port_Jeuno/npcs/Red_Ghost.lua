-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -96.241, 0.001, 8.872, -- 1
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.519, 0.001, -7.582,
    -96.584, 0.001, -8.519, -- 10
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.241, 0.001, 7.794,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) then
        npc:setPos(-96.241, 0.001, 8.872, 24)
    elseif npc:atPoint(tpz.path.get(path, 10)) then
        npc:setPos(-96.584, 0.001, -8.519, 231)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 15)) then
        player:startEvent(314)
    else
        player:startEvent(34)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 314) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 15, true))
    end
end
