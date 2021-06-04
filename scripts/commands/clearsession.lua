---------------------------------------------------------------------------------------------------
-- func: clearsession
-- desc: Clears a target's account session allowing them to log back in if hung
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!clearsession <player>")
end

function onTrigger(player, target)
    -- validate target
    if (target == nil) then
        error(player, "You must supply the name of an offline player.")
    else
        local res = player:clearSession(target)
        if res then
            player:PrintToPlayer(string.format("Cleared %s's session.", target))
        else
            player:PrintToPlayer(string.format("No player named %s found.", target))
        end
    end
end