-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Phantom
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -232, -4, 106,
    -182, 0, 106,
    -180, 0, 97,
    -182, 4, 80,
    -239, 8, 77,
    -239, 8, 13,
    -221, 8, 13,
    -220, 8, 61,
    -192, 4, 76,
    -176, 4, 83,
    -176, 0, 105,
    -232, -4, 106,
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
