---------------------------------------------------------------------------------------------------
-- func: completeNyzulFloorObjective
-- desc: Completes the given Nyzul Isle Investigation floor objective
---------------------------------------------------------------------------------------------------

require("scripts/globals/missions")

cmdprops =
{
    permission = 3,
    parameters = "sss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!completeNyzulFloorObjective")
end

function onTrigger(player)
    if (player:getInstance() == nil) then
        error(player, string.format("Player is not inside an instance, so definitely not inside Nyzul Isle Investigation!"))
        return
    end

    if (player:getInstance():getID() ~= 51) then
        error(player, string.format("Player is not inside Nyzul Isle Investigation!"))
        return
    end

    local instance = player:getInstance()
    local stage = instance:getStage()
    local runeOfTransfer
    if ((stage % 2) == 0) then -- even floor
        runeOfTransfer = GetNPCByID(17093330, instance)
    else
        runeOfTransfer = GetNPCByID(17093331, instance)
    end

    local pos = runeOfTransfer:getPos()

   
    floorObjectiveComplete(instance)
    -- complete mission
    player:PrintToPlayer(string.format( "Completed Nyzul Isle Investigation floor objective - RoT POS X %s Y %s Z %s", pos.x, pos.y, pos.z))
end
