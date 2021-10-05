-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Specter
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
     102, 1, 93,
     83, 1, 83,
     44, 0, 46,
     25, 0, 46,
     5, 0, 65,
     6, 0, 97,
    -6, 0, 97,
    -6, 0, 65,
    -20, 0, 55,
    -26, 0, 39,
    -23, 0, 25,
    -7, 0, 14,
    -3, 0, -23,
     5, 0, -21,
     7, 0, 15,
     24, 0, 27,
     28, 0, 33,
     52, 0, 33,
     104, 0, -10,
     127, 0, -0,
     104, 0, -10,
     60, 0, 32,
     63, 0, 46,
     102, 1, 93,
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