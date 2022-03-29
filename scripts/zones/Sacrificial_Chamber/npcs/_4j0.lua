-----------------------------------
-- Area: Sacrificial Chamber
-- NPC:  Mahogany Door
-- !pos 299 0.1 349 163
-------------------------------------

require("scripts/globals/bcnm")
require("scripts/globals/missions")
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    local hexCollected =
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_GREED)   and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_ENVY)    and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_MALICE)  and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DECEIT)  and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PRIDE)   and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BALE)    and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DESPAIR) and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_REGRET)  and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RAGE)    and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_AGONY)   and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DOLOR)   and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_RANCOR)  and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_STRIFE)  and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_PENURY)  and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_BLIGHT)  and 1 or 0) +
        (player:hasKeyItem(tpz.ki.TABLET_OF_HEXES_DEATH)   and 1 or 0)

    if player:getCurrentMission(ASA) == tpz.mission.id.asa.SISTERS_IN_ARMS and hexCollected > 0 then
        player:startEvent(4)
    elseif EventTriggerBCNM(player, npc) then
        return 1
    else
        print("triggered")
        player:messageSpecial(ID.text.DOOR_SHUT)
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

    if csid == 4 then
        player:completeMission(ASA, tpz.mission.id.asa.SISTERS_IN_ARMS)
        player:addMission(ASA, tpz.mission.id.asa.PROJECT_SHANTOTTOFICATION)
    elseif EventFinishBCNM(player, csid, option) then
        return
    end

end
