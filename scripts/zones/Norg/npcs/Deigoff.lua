-----------------------------------
-- Area: Norg
--  NPC: Deigoff
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -0.834, -4.880, 33.366,
    -4.589, -4.100, 33.094,
    -11.405, -2.238, 32.242,
    -12.563, -1.966, 31.796,
    -13.490, -1.731, 31.137,
    -14.500, -1.469, 30.331,
    -15.542, -1.127, 29.167,
    -16.599, -0.718, 27.306,
    -16.942, -0.479, 26.102,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -17.648, -0.049, 23.175,
    -16.942, -0.479, 26.102,
    -16.599, -0.718, 27.306,
    -15.542, -1.127, 29.167,
    -14.500, -1.469, 30.331,
    -13.490, -1.731, 31.137,
    -12.563, -1.966, 31.796,
    -11.405, -2.238, 32.242,
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
    player:startEvent(86)
    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    npc:wait(0)
end
