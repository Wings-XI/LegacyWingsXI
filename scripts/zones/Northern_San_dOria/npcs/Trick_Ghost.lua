-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Ghost
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -124, 0, 70,
    -110, 0, 56,
    -96, 0, 57,
    -89, 0, 61,
    -74, 0, 58, 
    -27, 0, 57,
    -12, 0, 52,
    -6, 0, 57,
     8, 0, 56,
     14, 0, 50,
     13, 0, 27,
     8, 0, 22,
    -8, 0, 23,
    -13, 0, 27,
    -21, 0, 56,
    -42, 0, 62,
    -112, 0, 62,
    -134, 0, 85,
    -140, 0, 106,
    -158, 0, 107,
    -157, 0, 89,
    -143, 0, 89,
    -124, 0, 70,
}

function onSpawn (npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.TRICK_OR_TREAT)
end