---------------------------------------------------------------------------------------------------
-- func: getgroupid
-- desc: Prints the group ID of the currently selected mob
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    
    if (targ ~= nil) then
        local gid = targ:getGroupID()
        
        if (gid == nil) then
            player:PrintToPlayer("!getgroupid ... an error occurred.")
            return 0
        end
        
        player:PrintToPlayer(string.format("%s's GROUP ID is: %u ", targ:getName(), gid))
    else
        player:PrintToPlayer("No target is selected.")
    end
end
