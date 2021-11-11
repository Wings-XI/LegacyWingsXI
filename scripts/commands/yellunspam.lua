-----------------------------------------------------------------------
-- func: yellunspam
-- desc:
-----------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function onTrigger(player, name)
    if name == nil then
        player:PrintToPlayer("!yellunspam: You must provide a player name.")
        player:PrintToPlayer("!yellunspam: usage: !yellunspam <player>")
        return
    end

    local readRules = GetCharVarByName(name, "YellReadRules")

    if readRules == nil then
        player:PrintToPlayer(string.format("!yellunspam: Player \"%s\" not found!", name))
        return
    end

    local result = SetCharVarByName(name, "YellSpamTime", 0)
    if result == nil then
        player:PrintToPlayer(string.format("!yellunspam: Failed to unmark \"%s\" as spam!", name))
        return
    end

    player:PrintToPlayer(string.format("\"%s\" is no longer marked as spam.", name), 29)
end
