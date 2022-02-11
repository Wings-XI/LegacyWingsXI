---------------------------------------------------------------------------------------------------
-- func:
-- desc:
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!dropitems")
end

function onTrigger(player)
    -- defunct, use Aluh Jambiya for godTH

    local tookEffect = player:forceDropItems()

    if tookEffect == true then

    else
        player:PrintToPlayer("Your current cursor target must be a monster type entity.")
    end
end
