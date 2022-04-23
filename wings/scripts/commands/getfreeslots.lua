---------------------------------------------------------------------------------------------------
-- func: getfreeslots <player>
-- desc: checks the current free slots of a player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getfreeslots [{player}]")
end

function onTrigger(player, targ)

    -- validate target
    if (targ == nil) then
        targ = player:getCursorTarget()
        if (targ == nil or not targ:isPC()) then
            targ = player
        end
    else
        local target = targ
        targ = GetPlayerByName(targ)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    player:PrintToPlayer(string.format("%s's free slots: %u", targ:getName(),targ:getFreeSlotsCount()))
end
