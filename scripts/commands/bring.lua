---------------------------------------------------------------------------------------------------
-- func: bring <player>
-- desc: Brings the target to the player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!bring <player> {forceZone}")
end

function onTrigger(player, target, forceZone)
    -- validate target
    if (target == nil) then
        error(player, "You must enter a target player name.")
        return
    end
    local targ = GetPlayerByName( target )
    if (targ == nil) then
        if not player:bringPlayer( target ) then
            error(player, string.format( "Player named '%s' not found!", target ) )
        end
        return
    end

    -- validate forceZone
    if (forceZone ~= nil) then
        if (forceZone ~= 0 and forceZone ~= 1) then
            error(player, "If provided, forceZone must be 1 (true) or 0 (false).")
            return
        end
    else
        forceZone = 1
    end

    -- bring target
    if (targ:getZoneID() ~= player:getZoneID() or forceZone == 1) then

        -- When zoning in and out of Mordion Gaol adjust the jail var
        local to_prison = 0
        local jail_cell = 0
        if player:getZoneID() == 131 then
            to_prison = 1
            jail_cell = player:getCharVar("inJail")
            if jail_cell == 0 then
                jail_cell = 1
            end
        end
        local in_prison = targ:getCharVar("inJail")
        if in_prison ~= 0 then
            in_prison = 1
        end
        if in_prison ~= to_prison then
            targ:setCharVar( "inJail", jail_cell )
        end

        targ:setPos( player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID() )
    else
        targ:setPos( player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos() )
    end
end
