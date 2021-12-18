-------------------------------------------
-- Vending Box in Nyzul Isle Investigation
-------------------------------------------

function onTrigger(player, npc)
	printf("Vending_Box onTrigger")
end

function onEventUpdate(player, csid, option)
	printf("Vending_Box onEventUpdate CSID %u OPTION %u", csid, option)
end

function onEventFinish(player, csid, option, npc)
    printf("Vending_Box onEventFinish CSID %u OPTION %u", csid, option)
end