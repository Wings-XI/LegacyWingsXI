-----------------------------------
-- Area: Lower Jeuno
--  NPC: Omer
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -86.526, 0.000, -119.860, -- 1
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -86.526, 0.000, -119.860,
    -88.534, 0.000, -123.455,
    -90.461, 0.000, -126.942,
    -90.752, 0.000, -127.466, -- 16
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -90.752, 0.000, -127.466,
    -88.534, 0.000, -123.455,
    -86.783, 0.000, -120.323,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) then
        npc:setPos(-86.526, 0.000, -119.860, 125)
    elseif npc:atPoint(tpz.path.get(path, 16)) then
        npc:setPos(-90.752, 0.000, -127.466, 132)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(206)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
