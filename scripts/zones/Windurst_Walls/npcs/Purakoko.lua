-----------------------------------
-- Area: Windurst Walls
--  NPC: Purakoko
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -72.580, -10.000, 115.877,
    -68.580, -10.002, 118.223,
    -66.538, -10.505, 119.421,
    -63.684, -11.289, 121.096,
    -61.175, -11.926, 122.568,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -59.242, -12.416, 123.703,
    -61.175, -11.926, 122.568,
    -63.684, -11.289, 121.096,
    -66.538, -10.505, 119.421,
    -68.580, -10.002, 118.223,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player, npc, trade)
    onStarlightSmilebringersTrade(player, trade, npc)
end

function onTrigger(player, npc)
    player:startEvent(318)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
