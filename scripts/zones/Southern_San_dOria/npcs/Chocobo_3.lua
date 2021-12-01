-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    17.079, 2.200, -100.110,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    13.350, 2.200, -100.356,
    19.627, 2.200, -97.389,
    17.754, 2.200, -99.761,
    19.627, 2.200, -97.389,
    16.944, 2.200, -97.278,
    17.707, 2.200, -99.819,
    19.627, 2.200, -97.389,
    17.597, 2.200, -96.827,
    19.627, 2.200, -97.389,
    17.407, 2.200, -99.630,
    17.345, 2.200, -96.794,
    19.864, 2.200, -97.119,
    17.407, 2.200, -99.630,
    17.345, 2.200, -96.794,
    17.407, 2.200, -99.630,
    19.864, 2.200, -97.119,
    16.354, 2.200, -100.158,
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
    -- player:startEvent(601)
    -- player:startEvent(820) --crazy hang
    -- player:startEvent(821) --crazy hang
    -- player:startEvent(600)
    -- player:startEvent(599)
    -- player:startEvent(862) -- cool choco debug menu
    -- player:startEvent(819)
    player:startEvent(818)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- printf("OPTION:", option)
end
