---------------------------------------------------------------------------------------------------
-- func: givetempitem
-- desc: Adds a temp item to a target player inventory.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "sii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!givetempitem <target> <itemID> <quantity>")
end

function onTrigger(player, target, itemId, quantity)

    if (target == nil or itemId == nil) then
        player:PrintToPlayer("You must enter a valid player name and item ID.")
        return
    end

    local targ = GetPlayerByName( target )
    if (targ == nil) then
        player:PrintToPlayer( string.format( "Player named '%s' not found!", target ) )
        return
    end

    -- validate itemId
    if (itemId ~= nil) then
        itemId = tonumber(itemId)
    end
    if (itemId == nil or itemId == 0) then
        error(player, "Invalid itemID.")
        return
    end

    -- validate quantity
    quantity = tonumber(quantity) or 1
    if (quantity == nil or quantity < 1) then
        error(player, "Invalid quantity.")
        return
    end

    -- add temp item
    targ:addTempItem(itemId, quantity, 0, 0, 0, 0, 0, 0, 0, 0)
	player:PrintToPlayer( string.format( "Gave player '%s' Temporary item with ID of '%u' ", target, itemId ) )
	targ:PrintToPlayer( "You have been given a temporary item." )
end
