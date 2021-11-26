-----------------------------------
-- Area: Upper Jeuno
--  NPC: Sibila-Mobla
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
-52, 0, 121,
-53, 0, 122,
-54, 0, 122,
-55, 0, 121,
-55, 0, 119,
-54, 0, 119,
-52, 0, 119,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 5)) then
        player:startEvent(10083)
    else
        player:startEvent(98)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10083) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 5, true))
    end
end
