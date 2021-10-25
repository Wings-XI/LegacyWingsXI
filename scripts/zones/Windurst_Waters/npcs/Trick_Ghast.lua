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
    144, 0, 160,
    147, 0, 149,
    147, -2, 134,
    124, -2, 112,
    122, -2, 93,
    108, -2, 81,
    107, -2, 65,
    135, -2, 32,
    159, -1, 9,
    145, 0, -14,
    172, 0, -15,
    159, -1, 9,
    135, -2, 32,
    107, -2, 65,
    108, -2, 81,
    122, -2, 93,
    124, -2, 112,
    147, -2, 134,
    147, 0, 166,
    148, -2, 207,
    98, -2, 202,
    99, -2, 170,
    116, 0, 171,
    126, 0, 186,
    147, 0, 184,
    147, 0, 167,
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