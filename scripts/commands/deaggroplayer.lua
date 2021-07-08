---------------------------------------------------------------------------------------------------
-- func: deaggroplayer
-- desc: Removes a mob's enmity for a specific player
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!deaggroplayer <player>")
end

function onTrigger(player, targname)
    
    local targ = player:getCursorTarget()
    
    if targ == nil or targ:isMob() == false then
        error(player, "you must select a target monster with the cursor first")
		return
    end
	if targname == nil or targname == "" then
		error(player, "you must specify a target player name")
		return
	end
    
	if targ:deaggroPlayer(targname) then
		player:PrintToPlayer(string.format("Cleared enmity against %s", targname))
	else
		player:PrintToPlayer(string.format("Could not clear enmity against %s, please check whether the name is spelled correctly.", targname))
	end
end
