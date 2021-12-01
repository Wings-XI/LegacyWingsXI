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
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    26.665, 2.200, -92.299,
    26.665, 2.200, -92.299,
    26.665, 2.200, -92.299,
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    26.665, 2.200, -92.299,
    26.665, 2.200, -92.299,
    26.665, 2.200, -92.299,
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    25.019, 2.200, -90.039,
    27.464, 2.200, -90.589,
    27.464, 2.200, -90.589,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    24.243, 2.200, -92.376,
    26.665, 2.200, -92.299,
    26.665, 2.200, -92.299,
    26.665, 2.200, -92.299,
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
