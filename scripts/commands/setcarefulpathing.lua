---------------------------------------------------------------------------------------------------
-- func: setcarefulpathing
-- desc: enables or disables careful pathing for mob
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setcarefulpathing {1,2}")
end

function onTrigger(player, cp)
    -- validate amount
    if (cp == nil or val == 0) then
        error(player, "Invalid amount. 1 for true, 2 for false")
        return
    end

    local targ = player:getCursorTarget()

    if targ == nil then
        player:PrintToPlayer("ERROR: No target is selected.")
        return
    end

    local aggro = targ:getAggro()
    local link = targ:getLink()
    local detection = targ:getDetectionType()

    if aggro == nil or link == nil or detection == nil then
        player:PrintToPlayer("ERROR: Invalid target or target is not a mob.")
        return
    end

    -- set careful pathing
    if cp == 1 then
        targ:setCarefulPathing(true)
    else
        targ:setCarefulPathing(false)
    end
end
