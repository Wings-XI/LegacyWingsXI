---------------------------------------------------------------------------------------------------
-- func: printtoplayer <player> <type> <message>
-- desc: Sends a chat message to a player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!printtoplayer <player> <type> <message>")
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
		error(player, "You must specify the target player name, the message type and message")
		return
	end

	local msg = nil
	local targetName = nil
	local msgType = nil
    if string.len(message) > 0 then
        local words = split(message, " ")
        if #words > 1 then
            targetName = words[1]
			msgType = words[2]
			msg = table.concat(words, " ", 3)
		end
	end

	if ((targetName == nil) or (msgType == nil) or (msg == nil)) then
		error(player, "All arguments are required")
		return
	end
	msgType = tonumber(msgType)
	if (msgType == nil) then
		error(player, "Message type has to be a number")
		return
	end
	
	local target = GetPlayerByName( targetName )
    if target == nil then
        error(player, string.format("Player %s not found.", targetName)) 
		return
    end
	
	target:PrintToPlayer(msg, msgType)
	player:PrintToPlayer(string.format("Sent message with type %i to player %s: %s", msgType, targetName, msg))

end
