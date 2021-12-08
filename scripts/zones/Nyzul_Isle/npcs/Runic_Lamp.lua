------------------------------------------
-- Runic Lamp in Nyzul Isle Investigation
------------------------------------------

function onTrigger(player, npc)
	printf("Runic_Lamp onTrigger")
end

function onEventUpdate(player, csid, option)
	printf("Runic_Lamp onEventUpdate CSID %u OPTION %u", csid, option)
end

function onEventFinish(player, csid, option, npc)
    printf("Runic_Lamp onEventFinish CSID %u OPTION %u", csid, option)
end