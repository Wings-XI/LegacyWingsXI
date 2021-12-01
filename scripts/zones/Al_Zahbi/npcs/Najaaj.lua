-----------------------------------
-- Area: Al Zahbi
--  NPC: Najaaj
-- Type: Standard NPC
-- !pos 61.563 -1 36.264 48
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    40.548, 0.000, 36.430,
    40.548, 0.000, 36.430,
    40.548, 0.000, 36.430,
    40.548, 0.000, 36.430,
    40.548, 0.000, 36.430,
    40.548, 0.000, 36.430,
    66.711, 0.000, 36.224,
    66.711, 0.000, 36.224,
    66.711, 0.000, 36.224,
    66.711, 0.000, 36.224,
    66.711, 0.000, 36.224,
    66.711, 0.000, 36.224,
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
    player:startEvent(241)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
