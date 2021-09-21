-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -173, 0, 129,
    -174, 4, 160,
    -175, 0, 179,
    -165, 0, 189,
    -165, 4, 208,
    -146, 12, 210,
    -131, 12, 227,
    -130, 12, 245,
    -139, 12, 253,
    -157, 12, 257,
    -141, 12, 270,
    -121, 12, 254,
    -132, 12, 231,
    -156, 12, 163,
    -196, 9, 162,
    -199, 9, 169,
    -183, 4, 168,
    -181, 4, 162,
    -174, 4, 162,
    -173, 0, 181,
    -162, 0, 187,
    -131, 0, 187,
    -123, 0, 178,
    -124, 0, 143,
    -138, 0, 126,
    -173, 0, 129,
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