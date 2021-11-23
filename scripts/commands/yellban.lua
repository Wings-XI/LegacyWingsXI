-----------------------------------------------------------------------
-- func: yellban
-- desc:
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(player, name)
    if name == nil then
        player:PrintToPlayer("!yellban: You must provide a player name.")
        player:PrintToPlayer("!yellban: usage: !yellban <player>")
        return
    end

    local infractions = GetCharVarByName(name, "YellInfractions")

    if infractions == nil then
        player:PrintToPlayer(string.format("!yellban: Player \"%s\" not found!", name))
        return
    end

    -- Increase infraction count by one.
    infractions = infractions + 1
    SetCharVarByName(name, "YellInfractions", infractions)

    -- Mute the player for a very, very long time.
    local muteTime = os.time() + 10 * 366 * 86400;
    local result = SetCharVarByName(name, "YellMuteTime", muteTime)
    if result ~= nil then
        result = SetCharVarByName(name, "YellBan", 1)
    end
    if result == nil then
        player:PrintToPlayer(string.format("!yellban: Failed to yell mute \"%s\"!", name))
        return
    end

    -- reset their rules state
    SetCharVarByName(name, "YellReadRules", 0)
    SetCharVarByName(name, "YellOptedIn", 0)

    player:PrintToPlayer(string.format("\"%s\" is permanently banned from yell. until %s.", name), 29)
end
