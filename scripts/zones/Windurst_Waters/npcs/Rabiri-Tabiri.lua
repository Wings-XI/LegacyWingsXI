-----------------------------------
-- Area: Windurst Waters
--  NPC: Rabiri-Tabiri
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
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -97.480, -2.000, 50.409, -- Force turn.
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -103.792, -2.000, 42.469, -- Force turn.
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -109.966, -2.000, 49.942, -- Force turn.
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
    player:startEvent(568)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
