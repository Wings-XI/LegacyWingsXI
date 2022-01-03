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
    -109.833, -2.000, 49.970, --1
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -109.833, -2.000, 49.970,
    -97.530, -2.000, 50.283, -- 9
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -97.530, -2.000, 50.283,
    -104.014, -2.000, 42.639, -- 17
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
    -104.014, -2.000, 42.639,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) then
        npc:setPos(-109.833, -2.000, 49.970, 246)
    elseif npc:atPoint(tpz.path.get(path, 9)) then
        npc:setPos(-97.530, -2.000, 50.283, 76)
    elseif npc:atPoint(tpz.path.get(path, 17)) then
        npc:setPos(-104.014, -2.000, 42.639, 141)
    end
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
