-----------------------------------
-- Area: Windurst Woods
--  NPC: Eight of Spades
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    95.891, -4.786, -77.369,
    94.799, -4.769, -74.579,
    93.615, -4.701, -71.557,
    90.963, -4.615, -64.793,
    89.878, -4.800, -62.142,
    90.144, -4.706, -64.076,
    90.510, -4.666, -66.743,
    91.520, -4.574, -74.101,
    91.925, -4.532, -74.990,
    92.753, -4.557, -75.877,
    94.909, -4.752, -77.947,
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
    player:startEvent(268)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
