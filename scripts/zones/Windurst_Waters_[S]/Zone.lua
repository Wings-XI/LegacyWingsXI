-----------------------------------
--
-- Zone: Windurst_Waters_[S] (94)
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/conquest")
require("scripts/globals/chocobo")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(157 + math.random(1, 5), -5, -62, 192)
    end

    if (not player:hasKeyItem(tpz.ki.INKY_BLACK_YAGUDO_FEATHER)) and (player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_TIGRESS_STIRS) == QUEST_AVAILABLE) then
        cs = 130 -- windy wotg intro CS
    elseif player:getCharVar("ManifestProblem") == 5 then
       cs = 153
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 153 then
        player:startEvent(231)
    elseif csid == 231 then
        player:startEvent(232)
    elseif csid == 232 then
        player:startEvent(233)
    elseif csid == 130 then
        player:addKeyItem(tpz.ki.INKY_BLACK_YAGUDO_FEATHER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.INKY_BLACK_YAGUDO_FEATHER)
    elseif csid == 233 then
        npcUtil.completeQuest(player, CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM, {item=5708, title=tpz.title.FRIEND_OF_LEHKO_HABHOKA, var="ManifestProblem"})
    end
end
