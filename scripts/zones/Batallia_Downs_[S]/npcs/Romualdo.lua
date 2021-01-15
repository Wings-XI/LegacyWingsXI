-----------------------------------
-- Area: Batallia Downs (S)
--  NPC: Romualdo
-- !pos 54.304 -13.832 141.055 84
-- Involved in Quest: Message on the Winds
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local questVar = player:getCharVar("Quest[7][1]Prog")

	if questVar == 1 then
		player:startEvent(109) -- Talked to Romualdo in Metalworks
	elseif questVar == 2 then
		player:startEvent(110) -- Text after quest began
	elseif questVar == 5 then
		player:startEvent(111) -- Quest completion, reward
	elseif player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.MESSAGE_ON_THE_WINDS) == QUEST_COMPLETED then
		player:startEvent(112) -- After quest
	else
		player:startEvent(102) -- Default text
	end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 109 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.MESSAGE_ON_THE_WINDS)
		player:setCharVar("Quest[7][1]Prog", 2)
	elseif csid == 111 then
		npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.MESSAGE_ON_THE_WINDS, {
            item = { 19202 },
            var = {"Quest[7][1]Prog"}
        })
        player:setCharVar("WindsPostCS", 1)
    end
end
