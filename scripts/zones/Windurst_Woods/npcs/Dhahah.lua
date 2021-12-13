-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahah
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    18.947, 0.000, 86.480,
    16.665, 0.000, 78.920,
    12.472, 0.000, 70.061,
    16.665, 0.000, 78.920,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end