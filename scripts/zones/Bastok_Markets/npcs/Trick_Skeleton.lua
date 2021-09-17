-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Skeleton
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -265, -10, -118,
    -222, -6, -118,
    -220, -6, -98,
    -205, -6, -90,
    -185, -6, -99,
    -200, -6, -118,
    -202, 4, -191,
    -200, -6, -104,
    -249, -8, -124,
    -269, -10, -105,
    -291, -10, -102,
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