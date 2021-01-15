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
    local tookEffect = player:zoneMazurka(false)
    if tookEffect == true then
        player:PrintToPlayer("Mazurka for current area has been set to disallowed.")
    else
        player:PrintToPlayer("Mazurka for current area is already set to disallowed.")
    end
    return
end
