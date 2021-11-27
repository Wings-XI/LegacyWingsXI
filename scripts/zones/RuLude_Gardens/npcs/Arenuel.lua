-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Arenuel
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
36, 2, 60,
36, 2, 60,
36, 2, 60,
36, 2, 60,
36, 2, 60,
36, 2, 60,
36, 2, 60,
35, 2, 66,
36, 2, 66,
36, 2, 66,
36, 2, 66,
36, 2, 66,
36, 2, 66,
36, 2, 66,
35, 2, 71,
36, 2, 71,
36, 2, 71,
36, 2, 71,
36, 2, 71,
36, 2, 71,
36, 2, 71,
35, 2, 60,
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
    player:startEvent(120)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
