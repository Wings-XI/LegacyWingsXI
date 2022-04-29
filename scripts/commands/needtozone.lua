---------------------------------------------------------------------------------------------------
-- func: needtozone
-- desc: Checks or sets the need to zone flag on a player
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 3,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!needtozone {player name} {optional value: 1 = true, 0 = false}")
end

function onTrigger(player, target, value)
    if value and not ((value == 1) or (value == 0)) then
        error(player, "Please specify a value of 1 for true or 0 for false.")
        return
    end

    if target then
        target = GetPlayerByName(target)
    end

    if not target or target:isNPC() or target:isMob() then
        error(player, "No valid target found. Specify a player name.")
        return
    end

    local oldValue = target:needToZone()
    local newValue = false
    if value then
        if value == 1 then
            target:needToZone(true)
            newValue = true
        else
            target:needToZone(false)
        end
        player:PrintToPlayer(string.format("Target name: %s (Target ID: %i) | Old needToZone value: %s | New needToZone value : %s", target:getName(), target:getID(), oldValue, newValue))
    else
        player:PrintToPlayer(string.format("Target name: %s (Target ID: %i) | needToZone value: %s", target:getName(), target:getID(), oldValue))
    end
end
