--------------------------------------------------
--
-- Nyzul Isle Investigation
--
--------------------------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/nyzul_isle")
require("scripts/globals/nyzul_isle_data")
--------------------------------------------------


function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.COMMENCING_ASSAULT, 51)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    for _,value in pairs(instance:getMobs()) do
       -- local mobID = value:getID()
        --printf(value:getName())
    end
    setMobTypes(instance)
    
end



function onInstanceTimeUpdate(instance, elapsed)
    local timePenalty = instance:getLocalVar("Nyzul_TimePenalty")
    --updateInstanceTime(instance, elapsed+(timePenalty*60), ID.text)

    if (instance:getLocalVar("Nyzul_CheckWin") > 0) then
        local win = false
        local objective = instance:getLocalVar("Nyzul_Objective")
        if (objective == 1) then -- Eliminate All Enemies
            win = evaluateEliminateAll(instance)
        elseif (objective >= 2 and objective <= 4) then
            win = evaluateEliminateSpecifiedOrLeader(instance)
        elseif (objective > 4) then -- Lamps
            win = evaluateLampObjective(instance)
        end

        if (win) then
            floorObjectiveComplete(instance)
        end
    end
end

function onInstanceFailure(instance)
    printf("onInstanceFailure\n")
    -- boot people?
end

function onInstanceProgressUpdate(instance, progress)
    printf("onInstanceProgressUpdate\n")
end

function onInstanceStageChange(instance)
    printf("onInstanceStageChange to %d\n", instance:getStage())
end

function onInstanceComplete(instance)
    printf("onInstanceComplete\n")
    -- complete the run
    -- apply gear penalty
    -- apply armband bonus
end

function onEventUpdate(player, csid, option)
    printf("onEventUpdate CSID %u OPTION %u\n", csid, option)
    if (csid == 95) then
        runeOfTransferSpawnPoint = generateFloor(player:getInstance():getStage(), player:getInstance())

        if (runeOfTransferSpawnPoint) then
            player:setPos(runeOfTransferSpawnPoint.x + math.random(-2, 2), runeOfTransferSpawnPoint.y, runeOfTransferSpawnPoint.z + math.random(-2, 2))
        end
    end
end

function onEventFinish(player, csid, option)
    printf("onEventFinish CSID %u OPTION %u\n", csid, option)
end

function floorObjectiveComplete(instance)
    local runeOfTransfer
            
    if ((instance:getStage() % 2) == 0) then -- even floor
        runeOfTransfer = GetNPCByID(17093330, instance)
    else
        runeOfTransfer = GetNPCByID(17093331, instance)
    end

    if (runeOfTransfer:AnimationSub() ~= 1) then
        instance:setLocalVar("Nyzul_CheckWin", 0)
        -- turn on runeOfTransfer
        runeOfTransfer:AnimationSub(1)

        for _,player in pairs(instance:getChars()) do
            player:messageSpecial(ID.text.OBJECTIVE_COMPLETE, instance:getStage())
        end
    end
end

function evaluateEliminateAll(instance)
    local mobs = instance:getMobs()
    for _,mob in pairs(mobs) do
        -- ignore Archaic Gear and Gears
        if (mob:isAlive() and not (mob:getFamily() ~= 119 or mob:getFamily() ~= 120)) then
            return false
        end
    end

    return true
end

function evaluateEliminateSpecifiedOrLeader(instance)
    for i=1,5 do
        local mobVarName = string.format("Nyzul_ObjectiveMob" ..i.. "")
        local mobID = instance:getLocalVar(mobVarName)
        if (mobID ~= 0) then
            local mob = GetMobByID(mobID, instance)
            if (mob:isAlive()) then
                return false
            end
        end
    end

    return true
end

function evaluateLampObjective(instance)
    for i=1,5 do
        local lampVarName = string.format("Nyzul_ObjectiveLamp" ..i.. "")
        local lampID = instance:getLocalVar(lampVarName)
        if (lampID ~= 0) then
            local lamp = GetNPCByID(lampID, instance)
            if (lamp:AnimationSub() ~= 1) then
                return false
            end
        end
    end

    return true
end
