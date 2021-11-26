-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Leis
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
-13, 2, 137,
-13, 2, 137,
-13, 2, 137,
-13, 2, 137,
-13, 2, 137,
-13, 2, 137,
-13, 2, 137,
-13, 2, 137,
-13, 2, 137,
-8, 2, 137,
-8, 2, 137,
-8, 2, 137,
-8, 2, 137,
-8, 2, 137,
-8, 2, 137,
-9, 2, 134,
-8, 2, 134,
-8, 2, 134,
-8, 2, 134,
-8, 2, 134,
-8, 2, 134,
-8, 2, 134,
-8, 2, 134,
-8, 2, 132,
-8, 2, 132,
-8, 2, 132,
-8, 2, 132,
-8, 2, 132,
-8, 2, 132,
-8, 2, 132,
-8, 2, 132,
-8, 2, 132,
-10, 2, 137,
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
    player:startEvent(119)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
