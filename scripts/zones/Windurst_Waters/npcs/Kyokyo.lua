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
    -208.588, -3.000, -61.340,
    -208.588, -3.000, -61.340,
    -208.588, -3.000, -61.340,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -211.882, -3.000, -64.415,
    -211.882, -3.000, -64.415,
    -211.882, -3.000, -64.415,
    -211.882, -3.000, -64.415,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
    -213.073, -3.000, -58.185,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end