-----------------------------------
-- Area: Chamber of Oracles
-- NPC:  Shimmering Circle
-- !pos -220 0 12 168
-------------------------------------

local bcnm = require("scripts/globals/bcnm")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    -- AMK 09
    local currentMission_AMK = player:getCurrentMission(AMK)

    if
        currentMission_AMK == tpz.mission.id.amk.RESCUE_A_MOOGLES_LABOR_OF_LOVE and
        player:getCharVar("[AMK]8_cs_seen") == 0 and
        player:hasKeyItem(tpz.ki.NAVARATNA_TALISMAN)
    then
        player:startEvent(5, 168)
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
    if csid == 5 then
        player:setCharVar("[AMK]8_cs_seen", 1)
        player:completeMission(AMK, tpz.mission.id.amk.RESCUE_A_MOOGLES_LABOR_OF_LOVE)
        player:addMission(AMK, tpz.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS)
    end
    EventFinishBCNM(player, csid, option)
end
