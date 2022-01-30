------------------------------------------
-- Runic Lamp in Nyzul Isle Investigation
------------------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
------------------------------------------------

local function setAllLamps(instance, onOrOff)
     for i=1,5 do
        local lampVarName = string.format("Nyzul_ObjectiveLamp" ..i.. "")
        local lampID = instance:getLocalVar(lampVarName)
        if (lampID ~= 0) then
            local lamp = GetNPCByID(lampID, instance)
            lamp:AnimationSub(onOrOff)
        end
    end
end

local function checkOrderWinCondition(instance)
    for i=1,5 do
        local lampVarName = string.format("Nyzul_ObjectiveLamp" ..i.. "")
        local lampID = instance:getLocalVar(lampVarName)
        if (lampID ~= 0) then
            local lamp = GetNPCByID(lampID, instance)
            if (lamp:getLocalVar("Nyzul_LampOrder") ~= lamp:getLocalVar("Nyzul_LampActivated")) then
                return false
            end
        end
    end

    return true
end

local function performOrderCheck(instance, npc)
    -- first turn on all lamps to show players that all lamps are activated
    setAllLamps(instance, 1)

    -- check for win condition
    if(checkOrderWinCondition(instance)) then
        -- renable win check in the instance
        instance:setLocalVar("Nyzul_CheckWin", 1)
        return
    else 
        -- reset progress (alternatively we could mod the progress with the number of lamps on the floor)
        instance:setProgress(0)
    end

    -- after a few seconds turn off lamps that dont match ordering - it takes ~5s for the lamps to turn on
    npc:timer(10000, function(npc)
        for i=1,5 do
            local lampVarName = string.format("Nyzul_ObjectiveLamp" ..i.. "")
            local lampID = instance:getLocalVar(lampVarName)
            if (lampID ~= 0) then
                 local lamp = GetNPCByID(lampID, instance)
                 if (lamp:getLocalVar("Nyzul_LampOrder") ~= lamp:getLocalVar("Nyzul_LampActivated")) then
                    lamp:AnimationSub(0)
                 end
                 lamp:setLocalVar("Nyzul_LampActivated", 0)
            end
        end
    end)

end

local function activateOneForInOrder(player, npc)
    local instance = player:getInstance()
    local order = instance:getProgress()

    -- disable automatic checking of the lamps during this phase
    instance:setLocalVar("Nyzul_CheckWin", 0)
    -- set the local var to the activation order and update progress
    npc:setLocalVar("Nyzul_LampActivated", order+1)
    instance:setProgress(order+1)

    for i=1,5 do
        local lampVarName = string.format("Nyzul_ObjectiveLamp" ..i.. "")
        local lampID = instance:getLocalVar(lampVarName)
        if (lampID ~= 0) then
            local lamp = GetNPCByID(lampID, instance)
            if (lamp:getLocalVar("Nyzul_LampActivated") == 0) then
                -- at least one lamp has not been activated yet
                return
            end
        end
    end

    performOrderCheck(instance, npc)

end

local function lightOneForAllAtTheSameTime(player, npc)
    local instance = player:getInstance()
    npc:AnimationSub(1)
    if (instance:getLocalVar("Nyzul_LampState") == 0) then
        instance:setLocalVar("Nyzul_LampState", 1)
        npc:timer(30000, function(npc)
            if (instance:getLocalVar("Nyzul_LampState") == 1) then
                instance:setLocalVar("Nyzul_LampState", 2)
                setAllLamps(instance, 0)
                npc:timer(30000, function(npc)
                    if (instance:getLocalVar("Nyzul_LampState") == 2) then
                        instance:setLocalVar("Nyzul_LampState", 0)
                    end
                end)
            end
        end)
    elseif (instance:getLocalVar("Nyzul_CheckWin") == 0) then
        -- the instance has detected that all lamps are on and stopped polling the win condition
        -- set the instance var to the success state
        instance:setLocalVar("Nyzul_LampState", 3)
    end
end

local function handleCertificationCodeRequired(player, npc)
    local checkForWin = false
    -- remove the player from certification codes remaining
    for i=1,6 do
        local lampVarName = string.format("Nyzul_LampCertCode" ..i.. "")
        local lampCertCode = npc:getLocalVar(lampVarName)
        if (lampCertCode == player:getID()) then
            npc:setLocalVar(lampVarName, 0)
            player:messageSpecial(7351) --ID.text.CERTIFICATION_REGISTERED)
            checkForWin = true
        end
    end

    -- if a code was registered, see if all codes have been registered
    if (checkForWin) then
        for i=1,6 do
            local lampVarName = string.format("Nyzul_LampCertCode" ..i.. "")
            local lampCertCode = npc:getLocalVar(lampVarName)
            if (lampCertCode ~= 0) then
                -- there is at least one cert code still set to a player ID
               return 
            end
        end
        npc:AnimationSub(1)
    else
        -- player's code already registered - reiterate that everyone must register
        player:messageSpecial(ID.text.CERTIFICATION_REQUIRED)
    end
end

function onTrigger(player, npc)
    local objective = npc:getLocalVar("Nyzul_LampObjective")
    
    if (objective == 5 and npc:AnimationSub() ~= 1) then
        handleCertificationCodeRequired(player, npc)
    elseif (objective == 6) then
        local instance = player:getInstance()

        local instanceLampsState = instance:getLocalVar("Nyzul_LampState")
        -- The states for lights all lamps at the same time are:
            -- 0, no action taken yet for this attempt
            -- 1, at least one lamp has been lit - 30s timer is running
            -- 2, the 30s timer has elapsed before all lamps have been lit

        -- initial states - and lamp not lit
        if (npc:AnimationSub() ~= 1 and instanceLampsState <= 1) then
            player:messageSpecial(ID.text.LAMP_SAME_TIME)
            player:startEvent(3, 5)
        -- waiting for all lamps (30s as per era)
        elseif (instanceLampsState == 1) then
            player:messageSpecial(ID.text.LAMP_NOT_ALL_ACTIVATED)
        -- missed the first 30s window - 30s penalty window.   SE was mean
        elseif (instanceLampsState == 2) then
            player:messageSpecial(ID.text.LAMP_MUST_WAIT)
        end

    elseif (objective == 7) then
        -- Nyzul_LampOrder
        if (npc:getLocalVar("Nyzul_LampActivated") == 0) then
            player:messageSpecial(ID.text.LAMP_SPECIFIC_ORDER)
            player:startEvent(3, 5)
        else
            player:messageSpecial(ID.text.LAMP_ALREADY_ACTIVATED)
        end
    end

end

function onEventUpdate(player, csid, option)
    -- there is an event update called for the lamp activating CS if the player selects yes
end

function onEventFinish(player, csid, option, npc)
    local objective = npc:getLocalVar("Nyzul_LampObjective")

    if (csid == 3 and option == 1) then
        -- player has selected to Activate the lamp
        if (objective == 6) then
            lightOneForAllAtTheSameTime(player, npc)
        elseif (objective == 7) then
            activateOneForInOrder(player, npc)
        end
    end
end

