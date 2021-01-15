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
        player:PrintToPlayer(string.format("%s's INT is: %u ", targ:getName(),targ:getStat(tpz.mod.INT)))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
