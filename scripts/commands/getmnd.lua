---------------------------------------------------------------------------------------------------
-- func: getmnd
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
        player:PrintToPlayer(string.format("%s's MND is: %u ", targ:getName(),targ:getStat(tpz.mod.MND)))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
