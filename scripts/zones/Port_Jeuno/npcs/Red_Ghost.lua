-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

local path =
{
-96, 0, 10,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, 8,
-96, 0, -10,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
-96, 0, -8,
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
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 15)) then
        player:startEvent(314)
    else
        player:startEvent(34)
    end

    -- wait until event is over
    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 314) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 15, true))
    end

    npc:wait(0)

end
