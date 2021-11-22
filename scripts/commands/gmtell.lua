---------------------------------------------------------------------------------------------------
-- func: gmtell
-- desc: Test GM tell prompt
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!gmtell <player> \"<message>\" <option 1> <option2> {<option3>...}")
end

-- Thanks Setzor for the word parsing logic
function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function onTrigger(player, message)

	if (message == nil) then
		error(player, "You must specify the target player name and message")
		return
	end

	local msg = nil
	local targetName = nil
    if string.len(message) > 0 then
        local words = split(message, " ")
        if #words > 1 then
            targetName = words[1]
			msg = table.concat(words, " ", 2)
		end
	end

	if ((targetName == nil) or (msg == nil)) then
		error(player, "You must both the target name and a message")
		return
	end

	local target = GetPlayerByName( targetName )
    if target == nil then
        error(player, string.format("Player %s not found.", targetName))
		return
    end

	target:PrintToPlayer(msg, 12, player:getName())
	player:PrintToPlayer(string.format("Sent GM tell to player %s: %s", targetName, msg))

    -- player:PrintToPlayer("\"Testing a GM\" tell message", 12)
end
