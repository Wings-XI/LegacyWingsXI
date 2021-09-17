-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Wight
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -193, -6, -83,
    -187, -6, -104,
    -212, -6, -92,
    -219, -6, -97,
    -200, -6, -119,
    -199, 2, -145,
    -166, 2, -124,
    -123, -2, -145,
    -109, -4, -142,
    -111, -4, -96,
    -159, -4, -83,
    -194, -6, -74,
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