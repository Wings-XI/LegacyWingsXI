-----------------------------------
-- Area: Windurst Waters
--  NPC: Trick Specter
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    106, -2, 46,
    123, -1, 44,
    159, -1, 10,
    159, 1, -25,
    159, -1, 10,
    123, -1, 44,
    106, -2, 41,
    77, -2, 26,
    34, -2, 51,
    -5, -1, 49,
    -8, -1, 20,
    10, -1, 23,
    0, -1, 38,
    0, -1, 50,
    34, -2, 49,
    62, -2, 37,
    78, -2, 25,
    106, -2, 42,
}

function onSpawn (npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onTrade(player, npc, trade)
    onHalloweenTrade(player, npc, trade)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.TRICK_OR_TREAT)
end