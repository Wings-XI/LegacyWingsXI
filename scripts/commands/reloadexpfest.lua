---------------------------------------------------------------------------------------------------
-- func: reloadexpfest
-- desc: Reload start and stop times of exp fest if enabled.
--
-- Allows changing the start and end time of exp fest, or to enable / disable
-- it completely, without having to restart the server.
-- Note that settings.lua has to be reloaded using !reloadglobal before using
-- this command for it to have any effect.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = ""
}

require("scripts/globals/events/exp_fest")

function onTrigger(player, globalLua, other)
    ExpFestReload()
    player:PrintToPlayer("Exp fest configuration reloaded.")
end
