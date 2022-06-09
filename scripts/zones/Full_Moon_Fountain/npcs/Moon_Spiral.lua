-----------------------------------
-- Area: Full Moon Fountain
-- NPC:  Moon Spiral
-- Involved in Quests: The Moonlit Path
-- !pos -302 9 -260 170
-----------------------------------

require("scripts/globals/bcnm")
require("scripts/globals/quests")
require("scripts/globals/missions")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(ASA) == tpz.mission.id.asa.FOUNTAIN_OF_TROUBLE then
        local sapsCollected =
            (player:hasKeyItem(tpz.ki.WATER_SAP_CRYSTAL)     and 1 or 0) +
            (player:hasKeyItem(tpz.ki.EARTH_SAP_CRYSTAL)     and 1 or 0) +
            (player:hasKeyItem(tpz.ki.ICE_SAP_CRYSTAL)       and 1 or 0) +
            (player:hasKeyItem(tpz.ki.WIND_SAP_CRYSTAL)      and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LIGHTNING_SAP_CRYSTAL) and 1 or 0) +
            (player:hasKeyItem(tpz.ki.FIRE_SAP_CRYSTAL)      and 1 or 0) +
            (player:hasKeyItem(tpz.ki.LIGHT_SAP_CRYSTAL)     and 1 or 0) +
            (player:hasKeyItem(tpz.ki.DARK_SAP_CRYSTAL)      and 1 or 0)

        if sapsCollected > 0 then
            player:startEvent(63)
        else
            EventTriggerBCNM(player, npc)
        end
    else
        EventTriggerBCNM(player, npc)
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
    if csid == 63 then
        player:completeMission(ASA, tpz.mission.id.asa.FOUNTAIN_OF_TROUBLE)
        player:addMission(ASA, tpz.mission.id.asa.BATTARU_ROYALE)
    else
        EventFinishBCNM(player, csid, option)
    end
end
