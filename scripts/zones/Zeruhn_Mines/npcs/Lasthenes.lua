-----------------------------------
-- Area: Zeruhn Mines
--  NPC: Lasthenes
-- Notes: Opens Gate
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    --[[
	if player:getXPos() > -79.5 then
        player:startEvent(180)
    else
        player:startEvent(181)
    end
	]]
	
	-- temporary until zeruhn fix
	if player:getXPos() > -79.5 then
        player:setPos(-82.523,0.286,19.941,128)
    else
        player:setPos(-76.950,0.000,20.043,0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
