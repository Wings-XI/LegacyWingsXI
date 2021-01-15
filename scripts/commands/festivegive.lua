---------------------------------------------------------------------------------------------------
-- func: festivegive <player> <itemId>
-- desc: Have the nearest festive moogle give an item to a player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "si"
}

function onTrigger(player, target, itemId)
    if (target == nil or itemId == nil) then
        player:PrintToPlayer("You must enter a valid player name and item ID.")
        return
    end

    local targ = GetPlayerByName( target )
    if (targ == nil) then
        player:PrintToPlayer( string.format( "Player named '%s' not found!", target ) )
        return
    end

    i = 0
    local currentItem = targ:getCharVar("festiveMoogle" .. tostring(i))
    while currentItem ~= 0 and i < 10 do
        i = i + 1
        currentItem = targ:getCharVar("festiveMoogle" .. tostring(i))
    end
    if i >= 10 then
        player:PrintToPlayer( string.format( "Player '%s' has too many items waiting", target) )
        return
    end
	itemIDNum = tonumber(itemId)
	if itemIDNum == nil or itemIDNum <= 0 then
		player:PrintToPlayer("Item ID must be a positive number")
		return
	end
    targ:setCharVar("festiveMoogle" .. tostring(i), itemIDNum)
    player:PrintToPlayer( string.format( "Festive Moogle will give item %d to player '%s'", itemId, target ) )
end
