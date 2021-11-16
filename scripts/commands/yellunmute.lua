-----------------------------------------------------------------------
-- func: yellunmute
-- desc:
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(player, name)
    if name == nil then
        player:PrintToPlayer("!yellunmute: You must provide a player name.")
        player:PrintToPlayer("!yellunmute: usage: !yellmute <player>")
        return
    end

    local infractions = GetCharVarByName(name, "YellInfractions")

    if infractions == nil then
        player:PrintToPlayer(string.format("!yellunmute: Player \"%s\" not found!", name))
        return
    end

    local currentTime = os.time()

    local muteTime = GetCharVarByName(name, "YellMuteTime")

    local isMuted = muteTime > currentTime

    if not isMuted then
        player:PrintToPlayer(string.format("!yellunmute: \"%s\" is not currently muted.", name))
        return
    end

    -- Remove an infraction.
    if infractions > 0 then
        infractions = infractions - 1
    end
    SetCharVarByName(name, "YellInfractions", infractions)

    -- Unmute the player.
    local result = SetCharVarByName(name, "YellMuteTime", 0)
    SetCharVarByName(name, "YellBan", 0)
    if result == nil then
        player:PrintToPlayer(string.format("!yellmute: Failed to yell unmute \"%s\"!", name))
        return
    end

    player:PrintToPlayer(string.format("\"%s\" is unmuted from yell.", name), 29)
end
