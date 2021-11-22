---------------------------------------------------------------------------------------------------
-- func: setfame <player> <zone> <amount>
-- desc: sets target's level of fame
-- courtesy of coreyms/topaz
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 5,
    parameters = "sii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setfame <player> <zone> <amount (1-9)>")
	player:PrintToPlayer("Zone Options: 1: San d'Oria, 2: Bastok, 3: Windurst, 4: Jeuno, 5: Selbina/Rabao, 6: Norg, 7: ALL")
end

function onTrigger(player, target, zone, amount)
    if (target == nil or zone == nil or amount == nil) then
        error(player, "You did not enter every value!")
        return
    end

	if (zone < 1 or zone > 7) then
		error(player, "Incorrect zone chosen, please pick from the list!")
		return
	end

	local zoneID = zone - 1;

	if (amount < 1 or amount > 9) then
		error(player, "Incorrect amount chosen, please choose between 1-9!")
		return
	end

	--Validate the target..
    local targ = GetPlayerByName(target)
    if (targ == nil) then
        player:PrintToPlayer(string.format( "Invalid player '%s' given.", target))
        return
    end

	local amountValue = 0

	if (amount == 1) then
	--	amountValue = 49 (retail value)
		amountValue = 199 -- era value
		player:PrintToPlayer("Rank 1 fame.")
	elseif (amount == 2) then
	--	amountValue = 50 (retail value)
		amountValue = 200 -- era 
		player:PrintToPlayer("Rank 2 fame.")
	elseif(amount == 3) then
	--	amountValue = 125 (retail value)
		amountValue = 500
		player:PrintToPlayer("Rank 3 fame.")
	elseif(amount == 4) then
	--	amountValue = 225 (retail value)
		amountValue = 900
		player:PrintToPlayer("Rank 4 fame.")
	elseif(amount == 5) then
	--	amountValue = 325 (retail value)
		amountValue = 1300
		player:PrintToPlayer("Rank 5 fame.")
	elseif(amount == 6) then
	--	amountValue = 425 (retail value)
		amountValue = 1700
		player:PrintToPlayer("Rank 6 fame.")
	elseif(amount == 7) then
	--	amountValue = 488 (retail value)
		amountValue = 1952
		player:PrintToPlayer("Rank 7 fame.")
	elseif(amount == 8) then
	--	amountValue = 550 (retail value)
		amountValue = 2200
		player:PrintToPlayer("Rank 8 fame.")
	elseif(amount == 9) then
	--	amountValue = 613 (retail value)
		amountValue = 2452
		player:PrintToPlayer("Rank 9 fame.")
	end

	-- Set the Fame
	if(zoneID == 6) then -- Handles the "ALL"
		targ:setFame(0, amountValue)
		targ:setFame(1, amountValue)
		targ:setFame(2, amountValue)
		targ:setFame(3, amountValue)
		targ:setFame(4, amountValue)
		targ:setFame(5, amountValue)
	else
		targ:setFame(zoneID, amountValue)
	end
	player:PrintToPlayer("You have set their fame.")
end
