-----------------------------------
-- Area: Windurst Waters
--  NPC: Pia
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -32.439, -2.500, -108.308,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
    -27.034, -2.500, -113.642,
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
    player:startEvent(597)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
