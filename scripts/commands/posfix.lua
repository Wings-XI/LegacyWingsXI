---------------------------------------------------------------------------------------------------
-- func: posfix
-- desc: Resets a targets account session and warps them to Jeuno.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!posfix <player>")
end

function onTrigger(player, target)
    -- validate target
    if (target == nil) then
        error(player, "You must supply the name of an offline player.")
    else
        local res = player:resetPlayer( target )
        if res then
            player:PrintToPlayer(string.format("Fixed %s's position.", target))
        else
            player:PrintToPlayer(string.format("No player named %s found.", target))
        end
    end
end
