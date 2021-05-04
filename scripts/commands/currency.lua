---------------------------------------------------------------------------------------------------
-- func: currency
-- desc: opts out of dynamis currency auto drops 
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
	if player:dynaCurrencyAutoDropEnabled() == true then
        player:dynaCurrencyAutoDropEnabled(false)
        player:PrintToPlayer("Successfully opted out of currency auto-drops for the remainder of this Dynamis instance.",29)
    end
	
end;
