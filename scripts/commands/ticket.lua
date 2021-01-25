-----------------------------------------------------------------------
-- func: ticket
-- desc: gets a list of the player's active gm tickets
-- Courtesy of Setzor from Eden
-----------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!ticket");
end

function onTrigger(player)
    if os.time() < player:getCharVar("[TicketsRead]") then
        player:PrintToPlayer("You must wait longer to use that command again.");
        return
    end

    local tickets = GetTickets(player:getName())
    player:setCharVar("[TicketsRead]", os.time() + 600)

    if #tickets > 0 then
        for _, record in ipairs(tickets) do
            player:PrintToPlayer(tostring(record), 0x1F)
        end
    else
        player:PrintToPlayer("You have no active tickets.", 0x1F)
    end
end
