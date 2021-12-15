-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhakih
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.RUN
local path =
{
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    -4.010, 0.000, 79.261,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
    3.596, 0.000, 78.553,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end