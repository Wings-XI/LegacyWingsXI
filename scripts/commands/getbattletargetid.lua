---------------------------------------------------------------------------------------------------
-- func: getbattletargetid
-- desc: Prints the battletargetID of the currently selected target under the cursor
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if (targ ~= nil) then
        player:PrintToPlayer(string.format("%s's current BattleTargetID is: %u ", targ:getName(),targ:getBattleTargetID()))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
