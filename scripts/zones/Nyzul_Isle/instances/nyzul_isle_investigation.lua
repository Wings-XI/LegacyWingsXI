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
    --setMobTypes(instance)
--messageAllPlayers(instance, "test")
    local once = false

    local tempmob = GetMobByID(17092751, instance)
    
    --[[tempmob:setSpawn(-20, -4, -20)
    if (not tempmob:isSpawned()) then
        SpawnMob(17092751, instance)
    end]]
    vendingBox = GetNPCByID(17093430, instance)
    entraceRuneOfTransfer = GetNPCByID(17093429, instance)
    --vendingBox:setStatus(tpz.status.NORMAL)
    entraceRuneOfTransfer:setStatus(tpz.status.NORMAL)

    local win = false
    if (win) then
        local runeOfTransfer
            
        if ((instance:getStage() % 2) == 0) then -- even floor
            printf("even")
            runeOfTransfer = GetNPCByID(17093330, instance)
        else
            printf("odd")
            runeOfTransfer = GetNPCByID(17093331, instance)
        end

        -- turn on runeOfTransfer
        runeOfTransfer:AnimationSub(1)

        for _,player in pairs(instance:getChars()) do
            player:messageSpecial(ID.text.OBJECTIVE_COMPLETE, instance:getStage())
        end
    end
    --printf("onInstanceTimeUpdate \n")
    
end

function onInstanceFailure(instance)
    printf("onInstanceFailure\n")
end

function onInstanceProgressUpdate(instance, progress)
    printf("onInstanceProgressUpdate\n")
end

function onInstanceStageChange(instance)
    printf("onInstanceStageChange to %d\n", instance:getStage())
end

function onInstanceComplete(instance)
    printf("onInstanceComplete\n")
end

function onEventUpdate(player, csid, option)
    printf("onEventUpdate CSID %u OPTION %u\n", csid, option)
    if (csid == 95) then
        runeOfTransferSpawnPoint, objectiveMobs = generateFloor(player:getInstance():getStage(), player:getInstance())
        --runeOfTransferSpawnPoint, objectiveMobs = generateFloor(20, player:getInstance())
        if (runeOfTransferSpawnPoint) then
            player:setPos(runeOfTransferSpawnPoint.x, runeOfTransferSpawnPoint.y, runeOfTransferSpawnPoint.z)
        else
            printf("wtfm8")
        end
    end
end

function onEventFinish(player, csid, option)
    printf("onEventFinish CSID %u OPTION %u\n", csid, option)
end