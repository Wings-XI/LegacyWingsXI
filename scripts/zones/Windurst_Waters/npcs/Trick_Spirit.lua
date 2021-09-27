-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Spirit
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -85, -3, 70,
    -82, -3, 63,
    -109, -2, 47,
    -97, -3, 23,
    -43, -2, 1,
    -31, -2, 7,
    -32, -3, 37,
    -39, -3, 42,
    -39, -5, 118,
    -31, -5, 130,
    -39, -5, 118,
    -41, -5, 89,
    -82, -5, 85,
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