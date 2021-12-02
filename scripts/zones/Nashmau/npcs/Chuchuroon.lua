-----------------------------------
-- Area: Nashmau
--  NPC: Chuchuroon
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -16.435, 0.000, -34.115,
    -16.435, 0.000, -34.115,
    -16.435, 0.000, -34.115,
    -16.435, 0.000, -34.115,
    -16.435, 0.000, -34.115,
    -16.435, 0.000, -34.115,
    -16.435, 0.000, -34.115,
    -20.826, 0.000, -44.997,
    -20.826, 0.000, -44.997,
    -20.826, 0.000, -44.997,
    -20.826, 0.000, -44.997,
    -20.826, 0.000, -44.997,
    -20.826, 0.000, -44.997,
    -20.826, 0.000, -44.997,
    -20.826, 0.000, -44.997,
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
    player:startEvent(266)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
