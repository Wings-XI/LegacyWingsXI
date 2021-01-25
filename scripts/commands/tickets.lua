-----------------------------------------------------------------------
-- func: tickets (shows tickets of online players)
--       tickets <player name>
--       tickets all
-- desc: gets a list of gm tickets
-- Courtesy of Setzor from Eden
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!tickets, !tickets <player name>, !tickets all");
end

function onTrigger(player, selector)
    local tickets = GetTickets(selector)

    if #tickets > 0 then
        for _, record in ipairs(tickets) do
            player:PrintToPlayer(tostring(record), 0x1F)
        end
    else
        player:PrintToPlayer(string.format("No tickets found for '%s'.", selector), 0x1F)
    end
end
