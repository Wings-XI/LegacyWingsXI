-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Shade
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    2, -1, 57,
    -14, -5, 87,
    -39, -5, 80,
    -40, -3, 36,
    -2, -1, 42,
    1, -1, 49,
    34, -2, 49,
    61, -2, 38,
    76, -2, 25,
    138, -2, 60,
    76, -2, 25,
    61, -2, 38,
    34, -2, 49,
    1, -1, 49,
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