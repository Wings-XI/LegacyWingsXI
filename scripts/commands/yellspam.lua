-----------------------------------------------------------------------
-- func: yellspam
-- desc:
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(player, name)
    if name == nil then
        player:PrintToPlayer("!yellspam: You must provide a player name.")
        player:PrintToPlayer("!yellspam: usage: !yellspam <player>")
        return
    end

    local readRules = GetCharVarByName(name, "YellReadRules")

    if readRules == nil then
        player:PrintToPlayer(string.format("!yellspam: Player \"%s\" not found!", name))
        return
    end

    -- Mark the player as spam for a week.
    local spamTime = os.time() + 86400 * 7
    local result = SetCharVarByName(name, "YellSpamTime", spamTime)
    if result == nil then
        player:PrintToPlayer(string.format("!yellspam: Failed to mark \"%s\" as spam!", name))
        return
    end

    player:PrintToPlayer(string.format("\"%s\" is marked as yell spam until %s", name, os.date("%c", spamTime)), 29)
end
