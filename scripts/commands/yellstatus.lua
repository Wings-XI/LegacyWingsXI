-----------------------------------------------------------------------
-- func: yellstatus
-- desc:
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(player, name)
    if name == nil then
        player:PrintToPlayer("!yellstatus: You must provide a player name.")
        player:PrintToPlayer("!yellstatus: usage: !yellstatus <player>")
        return
    end

    local readRules = GetCharVarByName(name, "YellReadRules")
    local isOptedIn = GetCharVarByName(name, "YellOptedIn")
    local muteTime = GetCharVarByName(name, "YellMuteTime")
    local spamTime = GetCharVarByName(name, "YellSpamTime")
    local infractions = GetCharVarByName(name, "YellInfractions")

    local currentTime = os.time()

    if readRules == nil then
        player:PrintToPlayer(string.format("!yellstatus: Player \"%s\" not found!", name))
        return
    end

    if readRules ~= 0 then
        player:PrintToPlayer(string.format("\"%s\" has read the yell rules.", name), 29)
    else
        player:PrintToPlayer(string.format("\"%s\" has NOT read the yell rules.", name), 29)
    end

    if isOptedIn ~= 0 then
        player:PrintToPlayer(string.format("\"%s\" has opted-in to participate in yells.", name), 29)
    else
        player:PrintToPlayer(string.format("\"%s\" has NOT opted-in to participate in yells.", name), 29)
    end

    if muteTime <= currentTime then
        player:PrintToPlayer(string.format("\"%s\" is not yell muted.", name), 29)
    else
        player:PrintToPlayer(string.format("\"%s\" is MUTED until %s", name, os.date("%c", muteTime)), 29)
    end

    if spamTime <= currentTime then
        player:PrintToPlayer(string.format("\"%s\" is not marked as yell spam.", name), 29)
    else
        player:PrintToPlayer(string.format("\"%s\" is makred as yell SPAM until %s", name, os.date("%c", spamTime)), 29)
    end

    player:PrintToPlayer(string.format("\"%s\" has been muted %d time(s).", name, infractions), 29)
end
