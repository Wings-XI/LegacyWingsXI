-----------------------------------
-- Area: Port Windurst
--  NPC: Reiso-Haroiso
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    45.821, -5.000, 121.300,
    45.736, -5.000, 124.757,
    45.669, -5.000, 127.514,
    45.736, -5.000, 124.757,
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
    player:startEvent(334)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
