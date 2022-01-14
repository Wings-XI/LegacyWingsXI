-----------------------------------
-- Area: Cloister of Storms
-- NPC:  Lightning Protocrystal
-- Involved in Quests: Trial by Lightning
-- !pos 534.5 -13 492 202
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Cloister_of_Storms/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/bcnm")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    local asaPrimal = player:getCharVar("ASA_Ramuh")

    if player:getCurrentMission(ASA) == tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(tpz.ki.DOMINAS_VIOLET_SEAL)
    and asaPrimal == 0 then
        player:messageSpecial(ID.text.POWER_STYMIES, tpz.ki.DOMINAS_VIOLET_SEAL)
        player:setCharVar("ASA_Ramuh", 1)
    elseif player:getCurrentMission(ASA) == tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(tpz.ki.DOMINAS_VIOLET_SEAL)
    and asaPrimal == 2 then
        player:startEvent(2)
        player:setCharVar("ASA_Ramuh", 3)
    elseif player:getCharVar("AnnyEvent2020") == 12 and Anniversary_Event_2021 == 1 then
        if player:getFreeSlotsCount() > 0 then
            player:addItem(4242)
            player:setCharVar("AnnyEvent2020", 13)
            player:PrintToPlayer("A spark strikes you from the crackling of the protocrystal...", 0xD)
            player:messageSpecial((ID.text.ITEM_OBTAINED), 4242)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4242)
        end
	elseif (EventTriggerBCNM(player, npc)) then
        return
    else
        player:messageSpecial(ID.text.PROTOCRYSTAL)
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid==2) then
        player:delKeyItem(tpz.ki.DOMINAS_VIOLET_SEAL)
        player:addKeyItem(tpz.ki.VIOLET_COUNTERSEAL)
        player:messageSpecial(ID.text.ATTACH_SEAL, tpz.ki.DOMINAS_VIOLET_SEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VIOLET_COUNTERSEAL)
        local sealCount = player:getCharVar("ASA_SealCount")
        player:setCharVar("ASA_SealCount", sealCount + 1)
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end
end
