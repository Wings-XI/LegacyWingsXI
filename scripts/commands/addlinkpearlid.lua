---------------------------------------------------------------------------------------------------
-- func: addlinkpearlid <linkshell id>
-- desc: Adds a linkpearl for a given linkshell to the GM's inventory.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "ii"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!addlinkpearl {linkshell ID} {slot ID}");
end;

function onTrigger(player, linkshellID, slotID)
    -- Load needed text ids for players current zone..
    local ID = zones[player:getZoneID()]

    -- validate linkshellID
    if (linkshellID == nil or tonumber(linkshellID) == nil or tonumber(linkshellID) == 0) then
        error(player, "Invalid linkshellID.");
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
    if player:addLinkpearl(linkshellID, slot) then
        player:messageSpecial( ID.text.ITEM_OBTAINED, 515 );
    else
        player:messageSpecial( ID.text.ITEM_CANNOT_BE_OBTAINED, 515 );
    end
end
