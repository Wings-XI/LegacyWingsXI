-----------------------------------
-- Area: Windurst Walls
--  NPC: Suhie-Kaihie
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -151.273, -2.500, 149.672,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
    -166.101, -2.500, 149.860,
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
    player:startEvent(291)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
