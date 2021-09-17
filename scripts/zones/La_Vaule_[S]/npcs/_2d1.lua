-----------------------------------
-- Area: La Vaule [S]
-- NPC:  Reinforced Gateway
-- Starting point for Purple the New Black
-- !pos -114.386 -3.599 -179.804 85
-------------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/missions")
-------------------------------------

function onTrigger(player, npc)
    if (player:getCurrentMission(WOTG) == tpz.mission.id.wotg.PURPLE_THE_NEW_BLACK and player:getCharVar("PurpleTheNewBlackProgress") == 0) then
        player:startEvent(2)
    elseif (EventTriggerBCNM(player, npc)) then
        return
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if (csid == 2) then
        player:setCharVar("PurpleTheNewBlackProgress", 1)
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end
end