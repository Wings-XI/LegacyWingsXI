-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Uricca-Koricca
-- Type: Standard NPC
-- !pos -102.221 -3 48.791 94
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -102.177, -2.000, 43.645,
    -102.177, -2.000, 43.645,
    -102.177, -2.000, 43.645,
    -102.177, -2.000, 43.645,
    -102.177, -2.000, 43.645,
    -102.177, -2.000, 43.645,
    -95.716, -2.000, 49.903,
    -95.716, -2.000, 49.903,
    -95.716, -2.000, 49.903,
    -95.716, -2.000, 49.903,
    -95.716, -2.000, 49.903,
    -95.716, -2.000, 49.903,
    -104.160, -2.000, 48.460,
    -104.160, -2.000, 48.460,
    -104.160, -2.000, 48.460,
    -104.160, -2.000, 48.460,
    -104.160, -2.000, 48.460,
    -104.160, -2.000, 48.460,
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
    player:startEvent(437)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
