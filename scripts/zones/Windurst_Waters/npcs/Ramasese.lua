-----------------------------------
-- Area: Windurst Waters
--  NPC: Ramasese
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    119.807, -1.875, 95.288,
    113.644, -1.907, 87.671,
    109.390, -2.000, 84.130,
    108.582, -2.000, 82.628,
    108.198, -2.000, 81.088,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    107.135, -2.000, 67.196,
    108.198, -2.000, 81.088,
    108.582, -2.000, 82.628,
    109.390, -2.000, 84.130,
    113.644, -1.907, 87.671,
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
end

function onTrigger(player, npc)
    player:startEvent(584)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
