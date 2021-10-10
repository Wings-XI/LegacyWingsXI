-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Bones
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -62, -4, -108,
    -56, -4, -128,
    -67, -4, -120,
    -127, -4, -117,
    -186, -6, -92,
    -198, -6, -84,
    -189, -6, -72,
    -120, -4, -95,
    -72, -4, -96,
    -55, -6, -82,
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