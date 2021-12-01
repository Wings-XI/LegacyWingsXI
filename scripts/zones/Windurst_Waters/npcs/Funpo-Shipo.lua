-----------------------------------
-- Area: Windurst Waters
--  NPC: Funpo-Shipo
-- Type: Standard NPC
-- !pos -44.091 -4.499 41.728 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -27.810, -3.500, 40.957,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
    -46.663, -3.500, 41.850,
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

    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 13)) then
        player:startEvent(938)
    else
        player:startEvent(576)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 938) then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 13, true))
    end
end
