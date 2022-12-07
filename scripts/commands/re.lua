---------------------------------------------------------------------------------------------------
-- func: re
-- desc: Reloads the party list (if bugged)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
	
    player:reloadParty(true)
	
end;
