-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Cermet Portal (Locked)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getXPos() < 480 then
        npc:openDoor()
    else
        player:messageSpecial(7230)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
