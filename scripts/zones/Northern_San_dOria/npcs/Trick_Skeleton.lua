-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Skeleton
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -26, 0, 58,
     4, 0, 57,
     24, 0, 47,
     53, 0, 32,
     90, 0, 0,
     102, 0, -11,
     114, 0, -8,
     125, 0, 2,
     118, 0, 1,
     104, 0, -9,
     51, 0, 33,
     27, 0, 33,
     4, 0, 14,
    -11, 0, 16,
    -23, 0, 25,
    -22, 0, 56,
    -26, 0, 58,
}

function onSpawn (npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onTrade(player, npc, trade)
    onHalloweenTrade(player, npc, trade)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.TRICK_OR_TREAT)
end