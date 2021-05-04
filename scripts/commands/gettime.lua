---------------------------------------------------------------------------------------------------
-- func: gettime
-- desc: prints current os time (seconds since 1970 epoch)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    player:PrintToPlayer(os.time())
end
