-----------------------------------
-- Area: Heaven's Tower
--  NPC: Chuqui-Chanqui
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -18.932, 0.500, -6.795,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
    -21.262, 0.500, 0.276,
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
    player:startEvent(80)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
