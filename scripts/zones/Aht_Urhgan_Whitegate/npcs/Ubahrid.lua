-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ubahrid
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    10.600, 0.000, -0.040,
    10.600, 0.000, -0.040,
    10.600, 0.000, -0.040,
    10.600, 0.000, -0.040,
    10.600, 0.000, -0.040,
    10.600, 0.000, -0.040,
    13.654, 0.000, 8.407,
    13.654, 0.000, 8.407,
    13.654, 0.000, 8.407,
    13.654, 0.000, 8.407,
    13.654, 0.000, 8.407,
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
    player:startEvent(672)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
