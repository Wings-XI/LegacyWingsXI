-----------------------------------
-- Area: Windurst Waters
--  NPC: Caliburn
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -43.049, -5.000, 129.379,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
    -44.462, -5.000, 128.041,
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
    player:startEvent(599)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
