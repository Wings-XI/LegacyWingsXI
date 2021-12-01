-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Tahl Mhioguch
-- Type: Standard NPC
-- !pos -64.907 -5.947 81.391 94
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -59.098, -3.573, 76.195,
    -59.098, -3.573, 76.195,
    -59.098, -3.573, 76.195,
    -59.098, -3.573, 76.195,
    -59.098, -3.573, 76.195,
    -59.098, -3.573, 76.195,
    -59.098, -3.573, 76.195,
    -59.098, -3.573, 76.195,
    -59.264, -3.629, 76.344,
    -59.264, -3.629, 76.344,
    -59.264, -3.629, 76.344,
    -65.138, -5.000, 81.597,
    -65.138, -5.000, 81.597,
    -65.138, -5.000, 81.597,
    -65.138, -5.000, 81.597,
    -65.138, -5.000, 81.597,
    -65.138, -5.000, 81.597,
    -65.138, -5.000, 81.597,
    -64.983, -5.000, 81.459,
    -64.983, -5.000, 81.459,
    -64.983, -5.000, 81.459,
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
    player:startEvent(438)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
