-----------------------------------
-- Area: Windurst Woods
--  NPC: Etsa Rhuyuli
-- Type: Standard NPC
-- !pos 62.482 -8.499 -139.836 241
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    62.150, -7.500, -138.060,
    62.843, -7.500, -141.761,
    63.382, -7.500, -144.635,
    62.843, -7.500, -141.761,
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
    local WildcatWindurst = player:getCharVar("WildcatWindurst")

    if player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatWindurst, 1) then
        player:startEvent(734)
    else
        player:startEvent(422)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 734 then
        player:setCharVar("WildcatWindurst", utils.mask.setBit(player:getCharVar("WildcatWindurst"), 1, true))
    end
end
