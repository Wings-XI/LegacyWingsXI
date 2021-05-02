---------------------------------------------------------------------------------------------------
-- func: removelastdynareservation
-- desc: removes target player's last dynamis reservation, resetting it so that they no longer have any 71h wait time
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!removelastdynareservation")
end

function onTrigger(player)
    local targ = player:getCursorTarget()

    if targ and targ:isPC() then
        targ:setCharVar("DynaReservationStart",0)
        player:PrintToPlayer(string.format("Removed %s's last Dynamis reservation.", targ:getName()))
    else
        error(player, "You must target a player with the game cursor.")
    end

end
