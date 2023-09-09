---------------------------------------------------------------------------------------------------
-- func: getta
-- desc:
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if (targ ~= nil) then
        local tatarget = player:getTrickAttackChar(targ)
        if (tatarget ~= nil) then
            player:PrintToPlayer(string.format("%s", tatarget:getName()))
        else
            player:PrintToPlayer("No valid TA target found.")
        end
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
