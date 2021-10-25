-----------------------------------
-- Area: Stellar Fulcrum
-- NPC: Qe'Lov Gate
-- !pos -0.63 200 -387.67 96
-------------------------------------

require("scripts/globals/bcnm")
require("scripts/globals/missions")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)

    if (EventTriggerBCNM(player, npc)) then
        return 1
    end

end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventUpdate(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)

    if (EventUpdateBCNM(player, csid, option)) then
        return
    end

end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (EventFinishBCNM(player, csid, option)) then
        return
    end

end
