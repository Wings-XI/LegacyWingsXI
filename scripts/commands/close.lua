-----------------------------------------------------------------------
-- func: close <player name | ticket ID>
-- desc: close GM tickets
-- Courtesy of Setzor from Eden
-----------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!close <player name> or <ticket ID>");
end

function onTrigger(player, input)
    if input ~= nil and input ~= '' then
        local ticketID = tonumber(input)
        if ticketID ~= nil and ticketID > 0 then
            player:closeTicket(ticketID)
            player:PrintToPlayer(string.format("Ticket #%u closed.", ticketID), 0x1F)
        else -- close all tickets for the given player
            if input ~= "all" then
                local tickets = GetTickets(input)
                if #tickets > 0 then
                    for _, record in ipairs(tickets) do
                        -- % escapes [ see https://www.lua.org/pil/20.2.html
                        local tID = tonumber(string.sub(record, 2, string.find(record, " %["))) -- get ticket number
                        player:closeTicket(tID)
                        player:PrintToPlayer(string.format("Ticket #%u closed.", tID), 0x1F)
                    end
                else
                    error(player, string.format("No player by the name '%s'", input))
                end
            else
                error(player, "Closing all tickets is not supported.")
            end
        end
    else
        error(player, "No input provided")
    end
end
