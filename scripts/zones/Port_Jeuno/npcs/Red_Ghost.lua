-----------------------------------
-- Area: Port Jeuno
--  NPC: Red Ghost
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -96.241, 0.001, 8.872, -- 1
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.241, 0.001, 8.872,
    -96.519, 0.001, -7.582,
    -96.584, 0.001, -8.519, -- 10
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.584, 0.001, -8.519,
    -96.241, 0.001, 7.794,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
    if npc:atPoint(tpz.path.get(path, 1)) then
        npc:setPos(-96.241, 0.001, 8.872, 24)
    elseif npc:atPoint(tpz.path.get(path, 10)) then
        npc:setPos(-96.584, 0.001, -8.519, 231)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    local FellowQuest = player:getCharVar("[Quest]Unlisted_Qualities")
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 15)) then
        player:startEvent(314)
    elseif player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and player:getMaskBit(FellowQuest,1) == false then
        player:startEvent(320,0,0,0,0,0,0,0,player:getFellowValue("fellowid"))
    else
        player:startEvent(34)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 314) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 15, true))
    elseif csid == 320 and option >= 0 and option <= 11 then
        local personality = {4,8,12,16,40,44,20,24,28,32,36,48}
        player:setFellowValue("personality", personality[option+1])
        player:setMaskBit(player:getCharVar("[Quest]Unlisted_Qualities"),"[Quest]Unlisted_Qualities",1,true)
    end
end
--[[
Adventuring Fellow Personality Options:
    Male:
        0   Sullen
        1   Passionate
        2   Calm and collected
        3   Serious
        4   Childish
        5   Suave
    Female:
        6   Sisterly
        7   Lively
        8   Agreeable
        9   Naive
        10  Serious
        11  Domineering
--]]
