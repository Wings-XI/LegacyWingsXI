----------------------------------
-- Area: Bastok Markets [S]
--  NPC: GentleTiger
-- Type: Quest
-- !pos -203  -10  1
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local onSabbatical = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.ON_SABBATICAL)
    local onSabbaticalProgress = player:getCharVar("OnSabbatical")
    local lightInTheDarknessProgress = player:getCharVar("LightInTheDarkness")

    if (onSabbatical == QUEST_ACCEPTED) then
        if (onSabbaticalProgress == 1) then
            player:startEvent(46)
        else
            player:startEvent(47)
        end
    elseif (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_ACCEPTED) then
        if (player:getCharVar("FiresOfDiscProg") == 5) then
            player:startEvent(160)
        else
            player:startEvent(161)
        end
    elseif (player:getCurrentMission(WOTG) == tpz.mission.id.wotg.CAIT_SITH or player:hasCompletedMission(WOTG, tpz.mission.id.wotg.CAIT_SITH)) and
           (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_COMPLETED) then
        if (lightInTheDarknessProgress == 10) then 
            player:startEvent(27) -- Completion CS
        elseif (lightInTheDarknessProgress > 1) then 
            player:startEvent(17) -- Ponders how an assassin got by
        else -- no progress 
            player:startEvent(16) -- initial CS
        end
    else
        player:startEvent(109)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 46) then
        player:setCharVar("OnSabbatical", 2)
    elseif (csid == 160) then
        player:setCharVar("FiresOfDiscProg", 6)
    elseif (csid == 16) then
        player:setCharVar("LightInTheDarkness", 1)
        npcUtil.addQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS)
    elseif (csid == 27) then
        npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.LIGHT_IN_THE_DARKNESS, {item=655, var="LightInTheDarkness"})
    end
end
