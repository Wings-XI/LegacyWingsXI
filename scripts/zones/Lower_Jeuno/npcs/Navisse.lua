-----------------------------------
-- Area: Lower Jeuno
--  NPC: Navisse
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
-62, 6, -90,
-64, 6, -88,
-64, 6, -88,
-64, 6, -88,
-64, 6, -88,
-64, 6, -88,
-64, 6, -88,
-59, 6, -90,
-56, 6, -90,
-54, 6, -91,
-54, 6, -91,
-54, 6, -91,
-54, 6, -91,
-54, 6, -91,
-54, 6, -91,
-63, 6, -86,
-63, 6, -86,
-63, 6, -86,
-63, 6, -86,
-63, 6, -86,
-63, 6, -86,
-63, 6, -86,
-59, 6, -92,
-55, 6, -94,
-55, 6, -94,
-55, 6, -94,
-55, 6, -94,
-55, 6, -94,
-55, 6, -94,
-55, 6, -94,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(153)
    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    npc:wait(0)
end
