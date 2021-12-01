-----------------------------------
-- Area: Windurst Waters
--  NPC: Janta-Jonta
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.RUN
local path =
{
    -97.897, -2.000, 43.691,
    -98.851, -2.000, 43.300,
    -103.309, -2.000, 42.171,
    -105.608, -2.000, 42.139,
    -109.440, -2.000, 42.243,
    -110.261, -2.000, 43.213,
    -110.604, -2.000, 43.858,
    -112.127, -2.000, 47.675,
    -111.858, -2.000, 48.171,
    -111.007, -2.000, 48.939,
    -106.684, -2.000, 51.447,
    -105.403, -2.000, 51.626,
    -104.531, -2.000, 51.710,
    -101.276, -2.000, 51.809,
    -100.479, -2.000, 51.425,
    -99.801, -2.000, 51.024,
    -99.194, -2.000, 50.611,
    -98.361, -2.000, 50.016,
    -94.997, -2.000, 47.632,
    -94.958, -2.000, 47.311,
    -95.388, -2.000, 46.363,
    -95.963, -2.000, 45.354,
    -97.419, -2.000, 43.907
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
    player:startEvent(567)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
