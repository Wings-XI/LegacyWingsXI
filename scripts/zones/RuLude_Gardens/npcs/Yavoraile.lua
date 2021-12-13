-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Yavoraile
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    26.778, 1.996, 70.493,
    29.529, 1.991, 66.675, -- Force turn.
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    30.045, 1.991, 66.677,
    29.568, 1.991, 68.861, -- Force turn.
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    30.173, 1.991, 68.864,
    27.243, 1.996, 70.500, -- Force turn.
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
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 4)) then
        player:startEvent(10092)
    else
        player:startEvent(118)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10092) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 4, true))
    end
end
