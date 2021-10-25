-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Trick Wight
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -242, 8, 44,
    -244, 8, 12,
    -234, 8, 18,
    -223, 8, 74,
    -178, 4, 75,
    -177, 0, 103,
    -234, -4, 105,
    -177, 0, 103,
    -178, 4, 75,
    -224, 8, 63,
    -223, 8, 74,
    -242, 8, 44,
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