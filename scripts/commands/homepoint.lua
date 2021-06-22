---------------------------------------------------------------------------------------------------
-- func: homepoint
-- desc: Sends the target to their homepoint.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!homepoint {player}")
end

function onTrigger(player, target)
    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName( target )
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    end

    -- When zoning in and out of Mordion Gaol adjust the jail var
    local to_prison = 0
    if zone == 131 then
        to_prison = 1
    end
    local in_prison = targ:getCharVar("inJail")
    if in_prison ~= 0 then
        in_prison = 1
    end
    if in_prison ~= to_prison then
        targ:setCharVar( "inJail", to_prison )
    end

    -- homepoint target
    targ:warp()
    if (targ:getID() ~= player:getID()) then
        player:PrintToPlayer(string.format("Sent %s to their homepoint.", targ:getName()))
    end
end
