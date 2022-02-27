---------------------------------------------------------------------------------------------------
-- func: getostime
-- desc: Prints the current server time
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    player:PrintToPlayer(tostring(os.time()), 29)
end
