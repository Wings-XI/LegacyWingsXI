-----------------------------------
-- Area: Windurst Waters
--  NPC: Kyokyo
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.RUN
local path =
{
    -209.084, -3.250, -100.559,
    -209.084, -3.250, -100.559,
    -209.084, -3.250, -100.559,
    -209.084, -3.250, -100.559,
    -205.729, -3.108, -98.984,
    -205.729, -3.108, -98.984,
    -205.729, -3.108, -98.984,
    -205.729, -3.108, -98.984,
    -208.634, -3.250, -96.121,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end