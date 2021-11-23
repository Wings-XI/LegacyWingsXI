---------------------------------------------------------------------------------------------------
-- func: geteva
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
        player:PrintToPlayer(string.format("%s's EVA is: %u ", targ:getName(),targ:getEVA()))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
