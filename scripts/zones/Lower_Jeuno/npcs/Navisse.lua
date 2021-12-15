-----------------------------------
-- Area: Lower Jeuno
--  NPC: Navisse
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -63.132, 6.000, -86.856, -- 1
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -53.970, 6.000, -91.572, -- 7
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
    -63.132, 6.000, -86.856, -- 13
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -64.597, 6.000, -89.351, -- 19
    -64.597, 6.000, -89.351,
    -64.597, 6.000, -89.351,
    -64.597, 6.000, -89.351,
    -64.597, 6.000, -89.351,
    -64.597, 6.000, -89.351,
    -63.132, 6.000, -86.856, -- 25
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -63.132, 6.000, -86.856,
    -55.556, 6.000, -94.394, -- 31
    -55.556, 6.000, -94.394,
    -55.556, 6.000, -94.394,
    -55.556, 6.000, -94.394,
    -55.556, 6.000, -94.394,
    -55.556, 6.000, -94.394,
    -53.970, 6.000, -91.572, -- 37
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
    -53.970, 6.000, -91.572,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) or npc:atPoint(tpz.path.get(path, 13)) or npc:atPoint(tpz.path.get(path, 25)) then
        npc:setPos(-63.132, 6.000, -86.856, 148)
    elseif npc:atPoint(tpz.path.get(path, 7)) or npc:atPoint(tpz.path.get(path, 37)) then
        npc:setPos(-53.970, 6.000, -91.572, 17)
    elseif npc:atPoint(tpz.path.get(path, 19)) then
        npc:setPos(-64.597, 6.000, -89.351, 148)
    elseif npc:atPoint(tpz.path.get(path, 31)) then
        npc:setPos(-55.556, 6.000, -94.394, 17)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(153)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end
