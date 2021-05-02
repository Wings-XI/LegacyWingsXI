---------------------------------------------------------------------------------------------------
-- func: adddynatime
-- desc: Adds an amount of time to the zone
---------------------------------------------------------------------------------------------------

require("scripts/globals/zone")

cmdprops =
{
    permission = 3,
    parameters = "ii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!adddynatime <minutes>")
end

function onTrigger(player, minutes)
    local extendMsg = {}
    extendMsg[tpz.zone.DYNAMIS_SAN_DORIA] = 7215
    extendMsg[tpz.zone.DYNAMIS_BASTOK] = 7315
    extendMsg[tpz.zone.DYNAMIS_WINDURST] = 7315
    extendMsg[tpz.zone.DYNAMIS_JEUNO] = 7215
    extendMsg[tpz.zone.DYNAMIS_BEAUCEDINE] = 7315
    extendMsg[tpz.zone.DYNAMIS_XARCABARD] = 7215
    extendMsg[tpz.zone.DYNAMIS_VALKURM] = 7315
    extendMsg[tpz.zone.DYNAMIS_BUBURIMU] = 7315
    extendMsg[tpz.zone.DYNAMIS_QUFIM] = 7315
    extendMsg[tpz.zone.DYNAMIS_TAVNAZIA] = 7315
    
    player:addTimeToDynamis(minutes, extendMsg[player:getZoneID()])
end
