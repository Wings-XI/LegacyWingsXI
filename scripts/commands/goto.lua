---------------------------------------------------------------------------------------------------
-- func: goto
-- desc: Goes to the target player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!goto <player> {forceZone}")
end

function onTrigger(player, target, forceZone)

    -- validate target
    if not target then
        error(player, "You must enter a player name.")
        return
    end

    -- validate forceZone
    if forceZone then
        if forceZone ~= 0 and forceZone ~= 1 then
            error(player, "If provided, forceZone must be 1 (true) or 0 (false).")
            return
        end
    else
        forceZone = 1
    end

    local targ = GetPlayerByName(target)
    -- if we found this player, they're on the same zone server
    -- if they're in mog house, goto them instead of setPos
    if targ and not targ:isInMogHouse() then

        -- When zoning in and out of Mordion Gaol adjust the jail var
        local to_prison = 0
        local jail_cell = 0
        if targ:getZoneID() == 131 then
            to_prison = 1
            jail_cell = targ:getCharVar("inJail")
            if jail_cell == 0 then
                jail_cell = 1
            end
        end
        local in_prison = player:getCharVar("inJail")
        if in_prison ~= 0 then
            in_prison = 1
        end
        if in_prison ~= to_prison then
            player:setCharVar( "inJail", jail_cell )
        end

        -- check for an instance
        if (targ and (targ:getInstance() ~= nil)) then
            -- Disabling until futher testing is done
            --local instance = targ:getInstance()
            --player:setInstance(instance)
        end

        player:setPos(targ:getXPos(), targ:getYPos(), targ:getZPos(), targ:getRotPos(), forceZone == 1 and targ:getZoneID() or nil)
    elseif not player:gotoPlayer(target) then
        error(player, string.format("Player named: %s not found!"), target)
    end
end
