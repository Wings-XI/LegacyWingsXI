-----------------------------------
-- Area: Port Bastok
--  NPC: Varden
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(141)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if player:hasKeyItem(tpz.ki.AIRSHIP_PASS) == false then
        player:setPos(-61.43 ,1.90 ,-7.85 ,254)
    end
end;
