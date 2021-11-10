-----------------------------------------------------------------------
-- func: message <player> "<message>"
-- desc: sends help desk/gm message to player
-- Courtesy of Setzor from Eden
-----------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!message <player> <message>");
end;

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function onTrigger(player, message)

    if string.len(message) > 0 then
        local words = split(message, " ")
        if #words > 1 then
            local targetName = words[1]
            local str, i = message:gsub("1", "",1)
            local msg = (i>0) and str or str:gsub("^.-%s", "",1)
            player:sendHelpDeskMsg(targetName, msg)
            player:PrintToPlayer(string.format("Message Sent: %s",msg));
        else
            error(player, "You must specify the message to send.");
        end
    end


end