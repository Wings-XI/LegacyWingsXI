-----------------------------------
-- Area: Port Windurst
--  NPC: Mosusu
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -41.726, -5.760, 138.836,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.662, -5.757, 138.717,
    -41.726, -5.760, 138.836,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
    -41.861, -5.760, 138.824,
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
    player:startEvent(329)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
