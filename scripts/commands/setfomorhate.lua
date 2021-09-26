---------------------------------------------------------------------------------------------------
-- func: setfomorhate <value> <player>
-- desc: sets the current fomor hate of a player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setfomorhate {value} [{player}]")
end

function onTrigger(player, value, targ)

    -- validate value
    if (value == nil) then
        error(player, "You must provide a value.")
        return
    end

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

    targ:setFomorHate(value)
    player:PrintToPlayer(string.format("Set %s's fomor hate to: %u", targ:getName(), targ:getFomorHate()))
end
