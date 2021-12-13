---------------------------------------------------------------------------------------------------
-- func: superpower
-- desc: Gives GM ability to equip any item and cast any spell
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function onTrigger(player, cmd)
    -- Obtain the players superpower status..
    local superPowers = player:getCharVar("GMSuperpower")
    if (cmd ~= nil) then
        if (cmd == "status") then
            player:PrintToPlayer(string.format('Current superpower status: %s', tostring(superPowers)))
            return
        end
    end

    -- Toggle the superpower status..
    if (superPowers == 0) then
        superPowers = 1
    else
        superPowers = 0
    end

    if (superPowers == 1) then
        player:setCharVar( "GMSuperpower", 1 )
        player:setGMSuperpowers(true)
        player:PrintToPlayer( "You now have GM superpowers." )
    else
        player:setCharVar( "GMSuperpower", 0 )
        player:setGMSuperpowers(false)
        player:PrintToPlayer( "You no longer have GM superpowers." )
    end
end
