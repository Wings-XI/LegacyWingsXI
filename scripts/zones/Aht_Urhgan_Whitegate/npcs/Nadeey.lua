-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Nadeey
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    
    if (IsCustomToAURingReacquisitionEnabled() > 0) then    -- server configured enablement/disablement of this custom behavior
        -- if player completed eternal merc, 
    else
        player:startEvent(251)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
