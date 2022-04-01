

function onTrigger(player, npc)
    player:startEvent(14, 0, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295)
end

function onEventUpdate(player, csid, option)
    player:PrintToPlayer(string.format( "onEventUpdate CSID: %d OPTION: %d", csid, option ))
end

function onEventFinish(player, csid, option)
    player:PrintToPlayer(string.format( "onEventFinish CSID: %d OPTION: %d", csid, option ))
end