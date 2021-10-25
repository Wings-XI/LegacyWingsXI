-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Specter
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -178, -8, -34,
    -235, -12, -30,
    -200, -8, -28,
    -199, -8, 27,
    -217, -8, 34,
    -154, -4, 30,
    -198, -8, 28,
    -198, -8, -30,
    -153, -4, -29,
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