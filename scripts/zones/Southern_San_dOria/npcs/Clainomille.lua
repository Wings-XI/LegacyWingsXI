-----------------------------------
-- Area: Southern San d'Oria
--   NPC: Clainomille
-- Type: Standard NPC
-- !pos -72.771 0.999 -6.112 230
-----------------------------------
require("scripts/globals/pathfind")
-------------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -74.997, 2.000, -4.190, -- Force turn.
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -76.530, 2.000, 0.443,
    -75.410, 2.000, 1.716, -- Force turn.
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -76.530, 2.000, 0.443,
    -74.918, 2.000, -4.125,
    -66.861, 2.000, -11.771, -- Force turn.
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
    player:startEvent(613)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
