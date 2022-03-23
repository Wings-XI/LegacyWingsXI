---------------------------------------------------------------------------------------------------
-- func: vercheckplayer
-- desc: Checks whether the target player is using the correct client version
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 3,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!vercheckplayer {player name}")
end

function onTrigger(player, target)
    
    local targ = nil
    if target ~= nil and target ~= "" then
        targ = GetPlayerByName(target)
    else
        targ = player:getCursorTarget()
    end
    
    if targ == nil then
        error(player, "A player name must be given or a player must be targeted")
        return
    end
    
    local ret = nil
    if targ:getObjType() == 1 then
        ret = targ:checkVersionMismatch()
    end
    if ret == nil then
        error(player, "Invalid player name or the selected target is not a player")
        return
    end
    
    if (ret == 0) then
        player:PrintToPlayer(targ:getName() .. "is are using the correct client version.")
    else
        player:PrintToPlayer(targ:getName() .. "is NOT using the correct client version.")
    end
end
