---------------------------------------------------------------------------------------------------
-- func: return <player>
-- desc: Warps GM or target player to their previous zone
---------------------------------------------------------------------------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!return {player}")
end

function onTrigger(player, target)

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    end

    -- get previous zone
    zoneId = targ:getPreviousZone()
    if (zoneId == nil or zoneId == tpz.zone.UNKNOWN or zoneId == tpz.zone.RESIDENTIAL_AREA) then
        error(player, "Previous zone was a Mog House or there was a problem fetching the ID.")
        return
    end

    -- When zoning in and out of Mordion Gaol adjust the jail var
    local to_prison = 0
    if zoneId == 131 then
        to_prison = 1
    end
    local in_prison = targ:getCharVar("inJail")
    if in_prison ~= 0 then
        in_prison = 1
    end
    if in_prison ~= to_prison then
        targ:setCharVar( "inJail", to_prison )
    end

    -- zone target
    targ:setPos( 0, 0, 0, 0, zoneId )
    if (targ:getID() ~= player:getID()) then
        player:PrintToPlayer( string.format( "%s was returned to zone %i.", targ:getName(), zoneId ) )
    end
end
