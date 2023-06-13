-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Regal Pawprints
-- !pos -700 -17.6 -327 182
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CHAMPION_OF_THE_DAWN) == QUEST_COMPLETED and
       player:getCharVar("TrialByCaitSeenCS") == 0 then
            player:delQuest(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_DAWN_ALSO_RISES)
            player:addQuest(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_DAWN_ALSO_RISES)
            player:startEvent(15)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
