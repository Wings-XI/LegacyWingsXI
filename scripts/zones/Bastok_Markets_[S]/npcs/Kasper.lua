----------------------------------
-- Area: Bastok Markets [S]
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -255.650, -12.000, -53.853,
    -255.650, -12.000, -53.853,
    -255.650, -12.000, -53.853,
    -255.650, -12.000, -53.853,
    -255.650, -12.000, -53.853,
    -255.650, -12.000, -53.853,
    -255.579, -12.000, -54.036,
    -255.579, -12.000, -54.036,
    -255.579, -12.000, -54.036,
    -251.599, -12.000, -64.419,
    -251.599, -12.000, -64.419,
    -251.599, -12.000, -64.419,
    -251.599, -12.000, -64.419,
    -251.599, -12.000, -64.419,
    -251.599, -12.000, -64.419,
    -251.826, -12.000, -64.119,
    -251.826, -12.000, -64.119,
    -251.826, -12.000, -64.119,
    -251.826, -12.000, -64.119,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    player:startEvent(152)
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;
