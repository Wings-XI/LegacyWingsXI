---------------------------------------------------------------------------------------------------
-- func: getenmity
-- desc: prints the target mob's current CE and VE towards the specified player
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getenmity")
end

function onTrigger(player, targetOfMob)

    local mob = player:getCursorTarget()

    if (not mob or not mob:isMob()) then
        error(player, "you must select a target monster with the cursor first")
        return
    end

    -- validate enmity target of mob
    local target
    if (not targetOfMob) then
        target = player
    elseif (targetOfMob == 'fellow') then -- only able to get one's own fellow or pet (for testing purposes)
        target = player:getFellow()
    elseif (targetOfMob == 'pet') then
        target = player:getPet()
    else
        target = GetPlayerByName(targetOfMob)
        if (not target) then
            error(player, string.format("Player named '%s' not found!", targetOfMob))
            return
        end
    end

    player:PrintToPlayer(string.format("%s's enmity against %s is ... CE = %u ... VE = %u ... TH = %u", target:getName(), mob:getName(), mob:getCE(target), mob:getVE(target), mob:getTHlevel()))

end
