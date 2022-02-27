---------------------------------------------------------------------------------------------------
-- func: customization
-- desc: Check if a customization is enabled in the server configuration.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "iii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!customization <Customization number>")
end

function onTrigger(player, customization)

    -- validate customization
    if customization == nil then
        error(player, "You must provide a customization nummber.")
        return
    end

    local is_enabled = IsCustomizationEnabled(customization) and "ENABLED" or "DISABLED"
    
    player:PrintToPlayer( string.format("Customization %i is " .. is_enabled .. "." , customization ) )
    
end
