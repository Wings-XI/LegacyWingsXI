---------------------------------------------------------------------------------------------------
-- func: getid
-- desc: Prints the HP of the currently selected target under the cursor
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if (targ ~= nil) then
        player:PrintToPlayer(string.format("%s's HP is: %u ", targ:getName(),targ:getHP()))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
