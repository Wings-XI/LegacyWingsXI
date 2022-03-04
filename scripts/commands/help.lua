---------------------------------------------------------------------------------------------------
-- func: help
-- desc: Prints the help menu
---------------------------------------------------------------------------------------------------

require("scripts/globals/settings")

cmdprops =
{
    permission = 0,
    parameters = ""
}

function error(player, msg)
    --player:PrintToPlayer(msg)
    --player:PrintToPlayer("!help")
end

function onTrigger(player)
    
    player:PrintToPlayer("== SERVER HELP MENU ==", 29, "", -1)
    player:PrintToPlayer("!help", 29, "", -1)
    player:PrintToPlayer("  Displays this help message.", 29, "", -1)
    player:PrintToPlayer("!flist", 29, "", -1)
    player:PrintToPlayer("  The custom in-game friends list. Type !flist help for a list", 29, "", -1)
    player:PrintToPlayer("!unstuck", 29, "", -1)
    player:PrintToPlayer("  In case you are stuck under the map, this sends you.", 29, "", -1)
    player:PrintToPlayer("  back to your homepoint. To prevent abuse your character", 29, "", -1)
    player:PrintToPlayer("  will be frozen in place for 20 minutes before teleportation.", 29, "", -1)
    player:PrintToPlayer("  The use of this command is logged and monitored.", 29, "", -1)
    player:PrintToPlayer("!re", 29, "", -1)
    player:PrintToPlayer("  Reloads the party list in the case of it loading improperly.", 29, "", -1)
    if SERVER_LINKSHELL ~= nil and SERVER_LINKSHELL > 0 then
        player:PrintToPlayer("!addls", 29, "", -1)
        player:PrintToPlayer("  Gives you a pearl to the server linkshell.", 29, "", -1)
        player:PrintToPlayer("  Use this command to reobtain the pearl if accidentaly dropped.", 29, "", -1)
    end
    if ALL_MAPS ~= nil and ALL_MAPS > 0 then
        player:PrintToPlayer("!maps", 29, "", -1)
        player:PrintToPlayer("  Gives you the maps of all zones.", 29, "", -1)
        player:PrintToPlayer("  Players are generally given all maps on character creation.", 29, "", -1)
        player:PrintToPlayer("  Only use this command if you do not already have them.", 29, "", -1)
    end
    player:PrintToPlayer("!vercheck", 29, "", -1)
    player:PrintToPlayer("  Checks if you are running the correct client version.", 29, "", -1)
    player:PrintToPlayer("  Bug reports will not be accepted unless the correct client", 29, "", -1)
    player:PrintToPlayer("  version is used.", 29, "", -1)

end
