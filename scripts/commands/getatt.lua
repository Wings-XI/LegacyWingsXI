---------------------------------------------------------------------------------------------------
-- func: getacc
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
        player:PrintToPlayer(string.format("%s's ATT is: %u ", targ:getName(),targ:getStat(tpz.mod.ATT)))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
