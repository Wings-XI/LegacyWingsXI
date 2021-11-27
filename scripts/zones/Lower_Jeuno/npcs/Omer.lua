-----------------------------------
-- Area: Lower Jeuno
--  NPC: Omer
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
-86, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-87, 0, -120,
-90, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
-91, 0, -127,
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
    player:startEvent(206)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
