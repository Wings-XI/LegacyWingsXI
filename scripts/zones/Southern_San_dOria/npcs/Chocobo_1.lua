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
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    11.348, 2.200, -87.631,
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    16.998, 2.200, -88.134,
    12.863, 2.200, -92.485,
    12.863, 2.200, -92.485,
    12.863, 2.200, -92.485,
    12.863, 2.200, -92.485,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
    18.566, 2.200, -91.972,
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
