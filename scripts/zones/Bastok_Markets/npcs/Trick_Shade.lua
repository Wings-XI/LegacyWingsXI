-----------------------------------
-- Area: Bastok Markets
--  NPC: Trick Shade
-- Harvest Festival Roaming Monster
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/events/harvest_festivals")
-----------------------------------
local path =
{
    -240, -12, -28,
    -255, -12, -87,
    -277, -12, -97,
    -346, -10, -166,
    -364, -10, -160,
    -344, -10, -181,
    -344, -10, -165,
    -280, -12, -96,
    -302, -12, -71,
    -282, -12, -39,
}

function onSpawn (npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onTrade(player, npc, trade)
    if isHalloweenEnabled() ~= 0 then
        onHalloweenTrade(player, npc, trade)
    end
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.TRICK_OR_TREAT)
end