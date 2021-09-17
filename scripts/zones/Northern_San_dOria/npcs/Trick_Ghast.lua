-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
   -160, 0, 90,
   -143, 0, 89,
   -111, 0, 60,
   -73, 0, 59,
   -26, 0, 57,
   -91, 0, 63,
    98, 0, 68,
   -108, 0, 69,
   -134, 0, 95,
   -137, 0, 107,
   -160, 0, 106,
   -159, 0, 94, 
   -160, 0, 90,
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