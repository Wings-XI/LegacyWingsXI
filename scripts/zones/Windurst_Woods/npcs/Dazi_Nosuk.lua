-----------------------------------
-- Area: Windurst Woods
--  NPC: Dazi Nosuk
-- Working 100%
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -48.584, -2.908, 14.903,
    -49.423, -3.284, 19.245,
    -50.150, -3.858, 24.000,
    -50.090, -3.640, 34.648,
    -50.150, -3.858, 24.000,
    -49.423, -3.284, 19.245,
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
    player:startEvent(428)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
