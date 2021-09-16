-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -47, -3, -71,
    -39, -3, -56,
    -8, -2, -22,
    -7, -1, 17,
    -4, -1, 67,
    -16, -5, 89,
    -38, -5, 76,
    -39, -3, 38,
    -7, -1, 35,
    -8, -2, -24,
    -45, -2, -62,
    -37, -2, -88,
    -36, -2, -104,
    -51, -2, -119,
    -51, -1, -165,
    -42, -1, -179,
    -4, -4, -180,
    -4, -2, -134,
    -36, -2, -102,
    -36, -2, -86,
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