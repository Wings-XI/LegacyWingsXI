---------------------------------------------------------------------------------------------------
-- func: vantime
-- desc: Shows the current in-game date
---------------------------------------------------------------------------------------------------

require("scripts/globals/quests")

cmdprops =
{
    permission = 0,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!vanatime")
end

function onTrigger(player)
    player:PrintToPlayer(VanadielDayAbsolute())
end
