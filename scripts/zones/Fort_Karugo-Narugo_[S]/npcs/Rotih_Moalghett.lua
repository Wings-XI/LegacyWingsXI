----------------------------------
-- Area: Fort Karugo Narugo [S]
--  NPC: Rotih_Moalghett
-- Type: Quest
-- !pos 280 -20 85 96
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STRIKES) == QUEST_ACCEPTED) then
        if (player:getCharVar("TigressStrikesProg") == 1) then
            player:startEvent(101)
        else
            player:startEvent(104)
        end
	elseif player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.KNOT_QUITE_THERE) == QUEST_COMPLETED and player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM) ~= QUEST_COMPLETED then
		if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM) == QUEST_AVAILABLE then
			player:startEvent(105)
		elseif player:getCharVar("ManifestProblem") == 2 then -- got cs from Castle O saying report back
			player:startEvent(106)
		elseif player:getCharVar("ManifestProblem") == 3 then -- continuiation cs
			player:startEvent(111)
		elseif player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM) == QUEST_ACCEPTED then
			player:startEvent(107)
		end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 104) then
        player:setCharVar("TigressStrikesProg", 1)
    elseif csid == 105 then
		player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM)
		player:setCharVar("ManifestProblem",1)
	elseif csid == 106 then
		player:setCharVar("ManifestProblem",3)
		player:startEvent(111)
	elseif csid == 111 then
		player:setCharVar("ManifestProblem",4)
		player:addKeyItem(tpz.ki.FORT_KEY)
		player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FORT_KEY)
    end
end
