-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhahih
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    6.110, 0.000, 122.311,
    15.913, 0.000, 111.901,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    20.867, 0.000, 106.642,
    15.913, 0.000, 111.901,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end