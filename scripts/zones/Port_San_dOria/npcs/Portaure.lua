-----------------------------------
-- Area: Port San d'Oria
--  NPC: Portaure
-- Standard Info NPC
-----------------------------------
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 3) -- FLYERS FOR REGINE
end

function onTrigger(player,npc)
    local MirrorMirror = player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.MIRROR_MIRROR)
    local MirrorMirrorProgress = player:getCharVar("[Quest]Mirror_Mirror")
    local fellowParam = getFellowParam(player)

    if MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress == 1 then
        player:startEvent(745,0,0,0,0,0,0,0,fellowParam)
    else
        player:startEvent(650) -- 651 starts quest "A Job For The Consortium"
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player,csid,option)
    if csid == 745 then
        player:setCharVar("[Quest]Mirror_Mirror", 2)
    end
end