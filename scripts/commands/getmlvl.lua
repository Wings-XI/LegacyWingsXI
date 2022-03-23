---------------------------------------------------------------------------------------------------
-- func: getmlvl
-- desc: Prints the main job level of the currently selected mob
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)

    local targ = player:getCursorTarget();
    
    if (targ == nil) then
        player:PrintToPlayer("A target must be selected.")
    end
    
    local mlvl = targ:getMainLvl()
    
    player:PrintToPlayer(string.format("%s's main job level is: %u ", targ:getName(), mlvl))

end
