---------------------------------------------------------------------------------------------------
-- func: cls
-- desc: developer tool, clear screen
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = ""
};

function onTrigger(player)
	local i = 0
    while i < 58 do
        player:PrintToPlayer("--",29)
        i = i + 1
    end
end
