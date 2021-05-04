---------------------------------------------------------------------------------------------------
-- func: getjobs
-- desc: prints what jobs the target has (main/sub)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if (targ ~= nil) then
        player:PrintToPlayer(string.format("%s main job is %u and sub job is %u", targ:getName(),targ:getMainJob(),targ:getSubJob()))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
