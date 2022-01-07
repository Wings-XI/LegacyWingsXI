-----------------------------------
-- Area: Windurst Walls
--  NPC: Pakeke
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -118.643, -5.000, 145.220, -- 1
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.219, -- 20
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
    -118.643, -5.000, 145.219,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) then
        npc:setPos(-118.643, -5.000, 145.220, 0)
    elseif npc:atPoint(tpz.path.get(path, 20)) then
        npc:setPos(-118.643, -5.000, 145.219, 121)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(292)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
