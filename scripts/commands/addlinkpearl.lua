---------------------------------------------------------------------------------------------------
-- func: addlinkpearl <linkshell name>
-- desc: Adds a linkpearl for a given linkshell to the GM's inventory.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "si"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!addlinkpearl {linkshell name} {slot ID}");
end;

function onTrigger(player, linkshellName, slotID)
    -- Load needed text ids for players current zone..
    local ID = zones[player:getZoneID()]

    -- validate linkshellName
    if (linkshellName == nil) then
        error(player, "Invalid linkshellName.");
        return;
    end
    
    local slot = nil
    if (slotID == 1 or slotID == 2) then
        slot = slotID
    end
    
    -- Ensure the GM has room to obtain the item...
    if (player:getFreeSlotsCount() == 0) then
        player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 515 );
        return;
    end
    
    -- Give the GM the item...
    if player:addLinkpearl(linkshellName, slot) then
        player:messageSpecial( ID.text.ITEM_OBTAINED, 515 );
    else
        player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 515 );
    end
end
