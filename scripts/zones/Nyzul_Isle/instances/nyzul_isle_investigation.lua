--------------------------------------------------
--
-- Nyzul Isle Investigation
--
--------------------------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/status")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/nyzul_isle")
require("scripts/globals/nyzul_isle_data")
require("scripts/globals/besieged")
--------------------------------------------------


function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.COMMENCING_ASSAULT, 51)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    -- sets mob types and other information required for nyzul
    setNyzulMobTypesAndTraits(instance)
end

function onInstanceTimeUpdate(instance, elapsed)
    local timePenalty = instance:getLocalVar("Nyzul_TimePenalty")
    updateInstanceTime(instance, elapsed+(timePenalty*60*1000), ID.text)

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
    local chars = instance:getChars()
    for _,char in pairs(chars) do
        char:messageSpecial(ID.text.MISSION_FAILED)
        char:release()
        char:disengage()
        char:timer(125, function(char)
            char:startEvent(1)
        end)
    end
end

function onInstanceProgressUpdate(instance, progress)
end

function onInstanceStageChange(instance, stage)
    if (stage == 101) then
        instance:setStage(1)
        instance:setLocalVar("Nyzul_BeatFloor100", 1)
    end
end

function onInstanceComplete(instance)
    local chars = instance:getChars()
    local startingFloor = instance:getLocalVar("Nyzul_StartingFloor")
    local endingFloor = instance:getStage()
    local beatFloor100 = instance:getLocalVar("Nyzul_BeatFloor100")
    local tokenPenlty = instance:getLocalVar("Nyzul_TokenPenalty")
    local numberOfPlayers = instance:getLocalVar("Nyzul_NumberOfPlayers")
    printf("calculateTokenReward - startingFloor %s endingFloor %s tokenPenalty %s numberOfPlayers %s beatFloor100 %s", startingFloor, endingFloor, tokenPenalty, numberOfPlayers, beatFloor100)
    local tokenReward = calculateTokenReward(startingFloor, endingFloor, beatFloor100, tokenPenlty, numberOfPlayers)

    for _,char in pairs(chars) do
        -- save runic disc progress
        local runicDiscProgress = char:getCharVar("Nyzul_RunicDiscProgress")
        local discProgressFloor = endingFloor
        if (beatFloor100 > 0) then discProgressFloor = 100 end

        if char:hasKeyItem(tpz.ki.RUNIC_DISC) and (runicDiscProgress + 1 >= startingFloor) and (discProgressFloor > runicDiscProgress) then
            char:setCharVar("Nyzul_RunicDiscProgress", discProgressFloor)
            char:messageSpecial(ID.text.RUNIC_DISC_PROGRESS_RECORDED, tpz.ki.RUNIC_DISC, discProgressFloor)
            -- could use a capture to determine what message is displayed for the runic key
            if ((discProgressFloor == 100) and (not char:hasKeyItem(tpz.ki.RUNIC_KEY))) then
                char:addKeyItem(tpz.ki.RUNIC_KEY)
                char:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RUNIC_KEY)
            end
        end

        -- reward with tokens
        local bonus = 0
        if (char:getCharVar("Assault_Armband") > 0) then
            bonus = 0.1
        end
        char:addAssaultPoint(NYZUL_ISLE_ASSAULT_POINT, math.floor(tokenReward + (tokenReward * bonus)))
        char:messageSpecial(ID.text.OBTAIN_TOKENS, math.floor(tokenReward + (tokenReward * bonus)))

        -- set victory flag
        char:setCharVar("AssaultComplete", 1)

        -- nyzul counts towards mercenary rank promotion
        if char:hasCompletedAssault(char:getCurrentAssault()) then
            char:setCharVar("AssaultPromotion", char:getCharVar("AssaultPromotion") +1)
        else
            char:setCharVar("AssaultPromotion", char:getCharVar("AssaultPromotion") +5)
        end

        --exit
        char:release()
        char:disengage()
        char:timer(125, function(char)
            char:startEvent(1)
        end)
        
    end
end

function onEventUpdate(player, csid, option)
    -- Bubble warp CS update - intentionally not handled in the Rune of Transfer
    if (csid == 95) then
        runeOfTransferSpawnPoint = generateFloor(player:getInstance():getStage(), player:getInstance())

        -- this logic could be reused for people who disconnect and come back mid-run
        if (runeOfTransferSpawnPoint) then
            player:setPos(runeOfTransferSpawnPoint.x + math.random(-2, 2), runeOfTransferSpawnPoint.y, runeOfTransferSpawnPoint.z + math.random(-2, 2))
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 1 then
        player:setPos(180, 0, 20, 90, 72)
    end

    if (csid == 95) then
        player:messageSpecial(ID.text.TRANSFER_COMPLETE, player:getInstance():getStage())
        showNyzulObjectivesAndPathos(player, true)
    end
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
        if (mob:isAlive() and not (mob:getFamily() == 119 or mob:getFamily() == 120)) then
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

function calculateTokenReward(startingFloor, endingFloor, beatFloor100, tokenPenalty, numberOfPlayers)
    local tokenReward = 0
    
    if (beatFloor100 > 0 and endingFloor ~= 100) then
        -- players beat floor 100 and chose to continue
        endingFloor = 100 + endingFloor
    end
    -- a floor gives a differnt base and bonus for differnt player numbers.  200/10 is for 3 players
    -- the bonusPerRange is applied per floor range of 5 (1-5, 6-10, 11-15, etc)
    -- the bonusPerRange continues to grow beyond floor 100 into floors 101-105, 106-110, etc
    local baseTokenGainPerFloor = 200
    local bonusPerRange = 10

    if (numberOfPlayers == 4) then
        baseTokenGainPerFloor = 180
        bonusPerRange = 9
    elseif (numberOfPlayers == 5) then
        baseTokenGainPerFloor = 160
        bonusPerRange = 8
    elseif (numberOfPlayers == 6) then
        baseTokenGainPerFloor = 140
        bonusPerRange = 7
    end

    for i = startingFloor, endingFloor do
        local addTokens = baseTokenGainPerFloor + (math.floor((i - 1) / 5) * bonusPerRange)
        tokenReward = tokenReward + addTokens
    end

    if (tokenReward - tokenPenalty) < 0 then
        return 0
    else
        return tokenReward - tokenPenalty
    end
end