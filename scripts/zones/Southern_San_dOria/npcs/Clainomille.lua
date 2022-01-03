-----------------------------------
-- Area: Southern San d'Oria
--   NPC: Clainomille
-- Type: Standard NPC
-- !pos -72.771 0.999 -6.112 230
-----------------------------------
require("scripts/globals/pathfind")
-------------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -66.767, 2.000, -11.673, -- 1
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -66.767, 2.000, -11.673,
    -74.918, 2.000, -4.125, -- 9
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -74.918, 2.000, -4.125,
    -76.530, 2.000, 0.443,
    -75.314, 2.000, 1.616, -- 18
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -75.314, 2.000, 1.616,
    -76.530, 2.000, 0.443,
    -74.918, 2.000, -4.125,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) then
        npc:setPos(-66.767, 2.000, -11.673, 224)
    elseif npc:atPoint(tpz.path.get(path, 9)) then
        npc:setPos(-74.918, 2.000, -4.125, 227)
    elseif npc:atPoint(tpz.path.get(path, 18)) then
        npc:setPos(-75.314, 2.000, 1.616, 37)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(613)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
