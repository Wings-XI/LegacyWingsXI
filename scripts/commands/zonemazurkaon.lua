---------------------------------------------------------------------------------------------------
-- func: 
-- desc: 
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!zonemazurkaon")
end

function onTrigger(player)
    local tookEffect = player:zoneMazurka(true)
    if tookEffect == true then
        player:PrintToPlayer("Mazurka for current area has been set to allowed.")
    else
        player:PrintToPlayer("Mazurka for current area is already set to allowed.")
    end
    return
end
