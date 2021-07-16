-----------------------------------
-- Area: Arrapago Reef
-- Door: Heavy Iron Gate
-- !pos 5 -9 579 54
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getXPos() < 8) then
        player:startEvent(106)
    else
        player:startEvent(107)
    end
end

function onEventUpdate(player, csid, option)
	if csid == 106 and option == 0 then
		for _, entry in pairs(player:getNotorietyList()) do
			entry:disengage() -- resetEnmity(player) is not consistently working on all mobs.
		end
	end
end

function onEventFinish(player, csid, option)
end
