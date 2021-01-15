---------------------------------------------------------------------------------------------------
-- func: getacc
-- desc: 
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if (targ ~= nil) then
        player:PrintToPlayer(string.format("%s's ACC is: %u ", targ:getName(),targ:getACC()))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
