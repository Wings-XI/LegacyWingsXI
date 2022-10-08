---------------------------------------------------------------------------------------------------
-- func: pardon
-- desc: Pardons a player from jail. (Mordion Gaol)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "ss"
}

function onTrigger(player, target, where)
    if (target == nil) then
        player:PrintToPlayer("You must enter a valid player name.")
        return
    end

    -- Validate the target..
    local targ = GetPlayerByName( target )
    if (targ == nil) then
        player:PrintToPlayer( string.format( "Invalid player '%s' given.", target ) )
        return
    end

    if (targ:getCharVar( 'inJail' ) >= 1) then
        local message = string.format( '%s is pardoning %s from jail.', player:getName(), targ:getName() )
        printf( message )

        targ:setCharVar( 'inJail', 0 )
        local returned = false
        if (where == "return") then
            local tozone = targ:getCharVar("JailedFromZone")
            if (tozone ~= 0) then
                local tox = targ:getCharVar("JailedFromX") / 1000
                local toy = targ:getCharVar("JailedFromY") / 1000
                local toz = targ:getCharVar("JailedFromZ") / 1000
                local torot = targ:getCharVar("JailedFromRot")
                targ:setPos(tox, toy, toz, torot, tozone)
                returned = true
            end
        end
        if (returned == false) then
            targ:warp()
        end
    end
end
