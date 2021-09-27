-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Shadow
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
-- Local Path Table for (x,y,z)-- 
local path =
{
     60, 0, 33,
     24, 0, 46,
     17, 0, 58,
    -1, 0, 65,
    -21, 0, 55,
    -31, 0, 62,
    -113, 0, 63,
    -133, 0, 83,
    -141, 0, 106,
    -159, 0, 106,
    -157, 0, 89,
    -142, 0, 88,
    -110, 0, 57,
    -96, 0, 58,
    -89, 0, 61,
    -73, 0, 57,
    -27, 0, 57,
    -13, 0, 52,
     12, 0, 53,
     52, 0, 32,
     60, 0, 33,
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