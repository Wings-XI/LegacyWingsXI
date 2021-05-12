-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door Rhinostery (south door)
-- Type: Quest NPC
-- !pos  3.168 -5.812 -197.000 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local lostBookQuestStatus = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_LOST_BOOK)
    local lostBookProgress = player:getCharVar("TheLostBookProgress")

    if lostBookQuestStatus == QUEST_AVAILABLE and player:hasKeyItem(tpz.ki.BRONZE_RIBBON_OF_SERVICE) and player:getMainLvl() >= 30 then
        player:startEvent(143) -- Quest start CS
    elseif lostBookProgress == 1 and not player:hasKeyItem(tpz.ki.LEATHERBOUND_BOOK) then
        player:startEvent(148) -- Reminds player to go to Giddeus CS
    elseif lostBookProgress == 2 and player:hasKeyItem(tpz.ki.LEATHERBOUND_BOOK) then
        player:startEvent(144) -- Player has the book CS, tells player to go to the Optistery
    elseif lostBookProgress == 3 then
        player:startEvent(150) -- Reminds player to go to the Optistery
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 143 then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_LOST_BOOK)
        player:setCharVar("TheLostBookProgress", 1)
    elseif csid == 144 then
        player:setCharVar("TheLostBookProgress", 3)
     end
end
