---------------------------------------------------------------------------------------------------
-- func: deaggroall
-- desc: Clears a mob's enmity list
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 2,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!deaggroall")
end

function onTrigger(player)

    local targ = player:getCursorTarget()

    if targ == nil or targ:isMob() == false then
        error(player, "you must select a target monster with the cursor first")
		return
    end

	if targ:deaggroAll() then
		player:PrintToPlayer("Cleared all enmity.")
	else
		player:PrintToPlayer("Could not clear enmity.")
	end

end
