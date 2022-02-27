---------------------------------------------------------------------------------------------------
-- func: vercheck
-- desc: Checks whether the player is using the correct client version
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 0,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!vercheck")
end

function onTrigger(player)
    ret = player:checkVersionMismatch()
    
    if (ret == 0) then
        player:PrintToPlayer("You are using the correct client version.")
    else
        player:PrintToPlayer("Client version mismatch. Please install the correct client version before reporting bug.")
    end
end
