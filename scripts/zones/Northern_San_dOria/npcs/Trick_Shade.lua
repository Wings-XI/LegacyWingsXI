-----------------------------------
-- Area: Northern San d'Oria
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
    -133, 12, 267,
    -127, 12, 208,
    -118, 6, 198,
    -128, 0, 186,
    -125, 0, 141,
    -141, 0, 128,
    -172, 0, 137,
    -175, 4, 162,
    -174, 0, 180,
    -165, 0, 190,
    -167, 4, 210,
    -170, 0, 235,
    -172, 0, 256,
    -163, 4, 267,
    -168, 4, 272,
    -173, 4, 269,
    -182, 9, 279,
    -176, 9, 282,
    -157, 12, 261,
    -148, 12, 260,
    -133, 12, 267,
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