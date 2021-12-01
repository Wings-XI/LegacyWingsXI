-----------------------------------
-- Area: Port Windurst
--  NPC: Machichi
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -106.567, -5.000, 169.822,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -113.700, -5.118, 178.268,
    -108.809, -5.000, 172.477,
    -106.296, -5.000, 170.138,
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
    player:startEvent(325)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
