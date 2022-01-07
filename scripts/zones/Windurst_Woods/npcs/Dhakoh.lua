-----------------------------------
-- Area: Windurst Woods
--  NPC: Dhakoh
-- Nonstandard Moving NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -21.048, -0.284, 103.128,
    -22.647, -0.125, 97.883,
    -22.980, -0.090, 96.793, -- 3
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.980, -0.090, 96.793,
    -22.647, -0.125, 97.883,
    -21.048, -0.284, 103.128, -- 15
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
    -21.048, -0.284, 103.128,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 3)) then
        npc:setPos(-22.980, -0.090, 96.793, 8)
    elseif npc:atPoint(tpz.path.get(path, 15)) then
        npc:setPos(-21.048, -0.284, 103.128, 13)
    end
end