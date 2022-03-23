---------------------------------------------------------------------------------------------------
-- func: addls
-- desc: Adds the server linkshell to the player's inventory.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function error(player, msg)
    player:PrintToPlayer(msg);
    -- player:PrintToPlayer("!addls");
end;

function onTrigger(player, linkshellName, slotID)
    -- Load needed text ids for players current zone..
    local ID = zones[player:getZoneID()]
    
    if (SERVER_LINKSHELL == nil or SERVER_LINKSHELL == 0) then
        error(player, "This server has no serverwide linkshell")
        return
    end

    -- Ensure the player has room to obtain the item...
    if (player:getFreeSlotsCount() == 0) then
        player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 515 );
        return;
    end
    
    -- Give the player the item...
    if player:addLinkpearl(SERVER_LINKSHELL) then
        player:messageSpecial( ID.text.ITEM_OBTAINED, 515 );
    else
        player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 515 );
    end
end
