-----------------------------------
-- Area: Al Zahbi
--  NPC: Sujyahn
-- Type: Standard NPC
-- !pos -48.213 -1 34.723 48
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.871, 0.000, 32.143,
    -50.745, 0.000, 32.265,
    -50.745, 0.000, 32.265,
    -50.745, 0.000, 32.265,
    -32.024, 0.000, 50.447,
    -32.024, 0.000, 50.447,
    -32.024, 0.000, 50.447,
    -32.024, 0.000, 50.447,
    -32.024, 0.000, 50.447,
    -32.024, 0.000, 50.447,
    -32.024, 0.000, 50.447,
    -32.024, 0.000, 50.447,
    -32.218, 0.000, 50.257,
    -32.218, 0.000, 50.257,
    -32.218, 0.000, 50.257,
    -32.218, 0.000, 50.257,
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
    player:startEvent(242)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
