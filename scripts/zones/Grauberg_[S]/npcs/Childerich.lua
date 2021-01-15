-----------------------------------
-- Area: Grauberg (S)
--  NPC: Childerich
-- !pos -312.844 16.235 -514.973 89
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

	if questVar == 2 then
		player:startEvent(1) -- Talked to Romualdo in Batallia Downs (S)
    elseif questVar == 3 then
        player:startEvent(2) -- Text after first CS with NPC
	elseif questVar == 4 then
		player:startEvent(4) -- Text after ??? CS
	elseif questVar == 5 then
		player:startEvent(5) -- New text after CS
    elseif player:getCharVar("WindsPostCS") == 2 then
		player:startEvent(6) -- After quest wrapup, title
    elseif player:getCharVar("WindsPostCS") == 0 and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.MESSAGE_ON_THE_WINDS) == QUEST_COMPLETED then
        player:startEvent(7)
	else
		player:startEvent(10) -- Default text
	end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 1 then
		player:setCharVar("Quest[7][1]Prog", 3)
    elseif csid == 4 then
		player:setCharVar("Quest[7][1]Prog", 5)
	elseif csid == 6 then
        player:addTitle(tpz.title.WINDTALKER)
        player:setCharVar("WindsPostCS", 0)
    end
end
