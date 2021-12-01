-----------------------------------
-- Area: Al Zahbi
--  NPC: Salaifa
-- Type: Standard NPC
-- !pos -37.462 -7 -41.665 48
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -37.523, -6.000, -37.966,
    -37.523, -6.000, -37.966,
    -37.523, -6.000, -37.966,
    -37.523, -6.000, -37.966,
    -37.523, -6.000, -37.966,
    -37.523, -6.000, -37.966,
    -37.664, -6.000, -41.466,
    -35.556, -6.000, -41.404,
    -35.556, -6.000, -41.404,
    -35.556, -6.000, -41.404,
    -35.556, -6.000, -41.404,
    -35.556, -6.000, -41.404,
    -35.556, -6.000, -41.404,
    -35.556, -6.000, -41.404,
    -37.664, -6.000, -41.466,
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
    player:startEvent(237)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
