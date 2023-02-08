-----------------------------------
-- Area: Cloister of Flames
-- NPC:  Fire Protocrystal
-- Involved in Quests: Trial by Fire, Trial Size Trial by Fire
-- !pos -721 0 -598 207
-----------------------------------

require("scripts/globals/keyitems")
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Cloister_of_Flames/IDs")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    local asaPrimal = player:getCharVar("ASA_Ifrit")

    if player:getCurrentMission(ASA) >= tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(tpz.ki.DOMINAS_SCARLET_SEAL)
    and asaPrimal == 0 then
        player:messageSpecial(ID.text.POWER_STYMIES, tpz.ki.DOMINAS_SCARLET_SEAL)
        player:setCharVar("ASA_Ifrit", 1)
    elseif player:getCurrentMission(ASA) >= tpz.mission.id.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(tpz.ki.DOMINAS_SCARLET_SEAL)
    and asaPrimal == 2 then
        player:startEvent(2)
        player:setCharVar("ASA_Ifrit", 3)
    elseif EventTriggerBCNM(player, npc) then
        return
    else
        player:messageSpecial(ID.text.PROTOCRYSTAL)
    end

end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    --printf("onFinish CSID: %u", csid)
    --printf("onFinish RESULT: %u", option)

    if (csid==2) then
        player:delKeyItem(tpz.ki.DOMINAS_SCARLET_SEAL)
        player:addKeyItem(tpz.ki.SCARLET_COUNTERSEAL)
        player:messageSpecial(ID.text.ATTACH_SEAL, tpz.ki.DOMINAS_SCARLET_SEAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SCARLET_COUNTERSEAL)
        local sealCount = player:getCharVar("ASA_SealCount")
        player:setCharVar("ASA_SealCount", sealCount + 1)
    elseif (EventFinishBCNM(player, csid, option)) then
        return
    end

end
