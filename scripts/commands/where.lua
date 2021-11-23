---------------------------------------------------------------------------------------------------
-- func: where
-- desc: Tells the player about their current position.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    player:showPosition()
end
