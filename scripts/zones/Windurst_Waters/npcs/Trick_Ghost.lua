-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Ghost
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -56, -5, 222,
    -40, -5, 216,
    -41, -5, 200,
    -49, -6, 186,
    -40, -5, 164,
    -39, -3, 39,
    -31, -3, 32,
    -32, -2, 6,
    -45, -2, 1,
    -98, -3, 24,
    -110, -2, 50,
    -78, -3, 64,
    -81, -5, 87,
    -40, -5, 86,
    -40, -5, 168,
    -49, -6, 186,
    -33, -4, 223,
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