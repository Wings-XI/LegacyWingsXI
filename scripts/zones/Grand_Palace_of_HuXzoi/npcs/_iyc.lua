-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Particle Gate
-- !pos -39 0 -319 34
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) >= tpz.mission.id.cop.WHEN_ANGELS_FALL then
        player:startEvent(172)
        return 1
    else
        player:messageSpecial(7230)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
