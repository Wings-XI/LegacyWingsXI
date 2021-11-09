-----------------------------------
-- Area: Stellar Fulcrum
-- Door: Qe'Lov Gate
-- !pos -520 -4 17 179
-------------------------------------

require("scripts/globals/bcnm")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(ACP) == tpz.mission.id.acp.BANISHING_THE_ECHO and player:hasKeyItem(tpz.ki.OMNIS_STONE) then
        player:startEvent(12)
    else
        EventTriggerBCNM(player, npc)
    end
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if csid == 12 then
        player:completeMission(ACP, tpz.mission.id.acp.BANISHING_THE_ECHO)
        player:addMission(ACP, tpz.mission.id.acp.ODE_OF_LIFE_BESTOWING)
    else
        EventFinishBCNM(player, csid, option)
    end
end
