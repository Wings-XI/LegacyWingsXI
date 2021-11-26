-----------------------------------
-- Area: Lower Jeuno
--  NPC: Jawantal
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
-64, -6, -130,
-65, -6, -130,
-65, -6, -130,
-65, -6, -130,
-65, -6, -130,
-65, -6, -130,
-65, -6, -130,
-65, -6, -130,
-65, -6, -130,
-65, -6, -130,
-67, -6, -133,
-68, -6, -133,
-68, -6, -133,
-68, -6, -133,
-68, -6, -133,
-68, -6, -133,
-68, -6, -133,
-68, -6, -133,
-68, -6, -133,
-68, -6, -133,
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
    player:startEvent(41)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
