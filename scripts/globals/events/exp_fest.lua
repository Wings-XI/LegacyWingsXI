---------------------------------------------------------------
-- Exp fest - Double xp for everyone!                        --
--(C) 2022 Wings Project. Coded by Twilight.                 --
---------------------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")

function ExpFestEnable(player, showmsg)
    
    print("ExpFestEnable: called")
    -- Sanity check
    local now = os.time()
    if EXP_FEST_END <= now then
        print("ExpFestEnable: event is not enabled, stopping")
        return -1
    end
    
    print(string.format("ExpFestEnable: player = %s, showmsg = %s", player:getName(), tostring(showmsg)))
    if player:getCharVar("ExpFestStatus") == 0 then
    
        print("ExpFestEnable: need to activate effect")
        -- Check if they already have dedication effect
        if player:hasStatusEffect(tpz.effect.DEDICATION) then
            -- Back it up to char var so we can restore it when event ends
            print("ExpFestEnable: player already has a dedication effect, saving backup")
            local old_effect = player:getStatusEffect(tpz.effect.DEDICATION)
            if old_effect == nil then
                -- Should never happen
                print("ExpFestEnable: old effect is nil, stopping")
                return -1
            end
            print(string.format("ExpFestEnable: old effect: type=%i, power=%i, subpower=%i, duration=%i", old_effect:getType(), old_effect:getPower(), old_effect:getSubPower(), old_effect:getDuration()))
            player:setCharVar("DedicationBackType", old_effect:getType())
            player:setCharVar("DedicationBackPower", old_effect:getPower())
            player:setCharVar("DedicationBackSubPower", old_effect:getSubPower())
            player:setCharVar("DedicationBackDuration", old_effect:getDuration())
            -- Event overrides old effect
            player:delStatusEffectSilent(tpz.effect.DEDICATION)
        end
        
        print("ExpFestEnable: setting status flag")
        -- Set this so this doesn't run every time the player zones
        player:setCharVar("ExpFestStatus", 1)
        
    end
    
    
    if not player:hasStatusEffect(tpz.effect.DEDICATION) then
    
        print("ExpFestEnable: no existing dedication effect, adding")
        -- Add the new effect
        -- Note that we intentionally set the remaining exp to 1 point. This will be
        -- overridden by the unlimited dedication local var. Setting the cap to 1
        -- ensures that if the player somehow still has the effect after the event
        -- ended it'll wear immediately.
        player:addStatusEffect(tpz.effect.DEDICATION, 100, 0, EXP_FEST_END - now, 0, 1)
        local dedication = player:getStatusEffect(tpz.effect.DEDICATION)
        if dedication ~= nil then
        
            print("ExpFestEnable: setting effect flags")
            -- Make it wear on zone because we'll be adding it each time,
            -- again, this is insurance against the effect accidentally
            -- remaining after the event ends
            dedication:setFlag(tpz.effectFlag.ON_ZONE)
            dedication:setFlag(tpz.effectFlag.LOGOUT)
        
        end

        print("ExpFestEnable: setting unlimited flag")
        -- Set the unlimited dedication var, which is a local var, so it needs to be
        -- set every time the player zones
        player:setLocalVar("unlimited_dedication", 1)
        
    end
    
    -- Friendly user message
    if showmsg ~= nil and showmsg then
        print("ExpFestEnable: adding print message timer")
        player:timer(2000, function(player) 
            print("ExpFestEnable: printing user message")
            player:PrintToPlayer(os.date("Exp fest has begun! All experience gained is now doubled, no cap.\nThe event lasts until %a, %Y/%m/%d %H:%M:%S UTC", EXP_FEST_END))
        end)
    end
    
    print("ExpFestEnable: finish")
    return 0
    
end

function ExpFestDisable(player, showmsg)

    print("ExpFestDisable: called")
    -- If they don't have it enabled no need to do anything
    if player:getCharVar("ExpFestStatus") == 0 then
        print("ExpFestDisable: fest not enabled, stopping")
        return 0
    end
    
    print(string.format("ExpFestDisable: player = %s", player:getName()))
    -- Remove their current dedication effect
    print("ExpFestDisable: removing flags")
    player:setLocalVar("unlimited_dedication", 0)
    player:setCharVar("ExpFestStatus", 0)
    if player:hasStatusEffect(tpz.effect.DEDICATION) then
        print("ExpFestDisable: removing effect")
        player:delStatusEffectSilent(tpz.effect.DEDICATION)
    end
    
    -- Restore any previous dedication effect they might have had
    -- when the event started
    local old_type = player:getCharVar("DedicationBackType")
    if old_type ~= nil and old_type > 0 then
    
        print("ExpFestDisable: restoring old dedication effect")
        player:addStatusEffect(tpz.effect.DEDICATION, player:getCharVar("DedicationBackPower"), 0, player:getCharVar("DedicationBackDuration"), 0, player:getCharVar("DedicationBackSubPower"))
        
        -- Delete the backup so we don't give it to them more than once
        player:setCharVar("DedicationBackType", 0)
        player:setCharVar("DedicationBackPower", 0)
        player:setCharVar("DedicationBackSubPower", 0)
        player:setCharVar("DedicationBackDuration", 0)        
        
        if showmsg ~= nil and showmsg then
            player:PrintToPlayer("Exp fest has now ended. Your previous dedication status has been restored.\nThank you for playing!")
        end
    
    else
    
        print("ExpFestDisable: no backup effect")
        if showmsg ~= nil and showmsg then
            player:PrintToPlayer("Exp fest has now ended.\nThank you for playing!")
        end        
    
    end
    
    print("ExpFestDisable: finish")
    return 0

end

function ExpFestEnableAll(showmsg)

    print("ExpFestEnableAll: called")
    local allPlayers = GetAllPlayers()
    
    for k,v in pairs(allPlayers) do
        
        ExpFestEnable(v, showmsg)
        
    end
    
    print("ExpFestEnableAll: finish")
end

function ExpFestDisableAll(showmsg)

    print("ExpFestDisableAll: called")
    local allPlayers = GetAllPlayers()
    
    for k,v in pairs(allPlayers) do
        
        ExpFestDisable(v, showmsg)
        
    end
    
    print("ExpFestDisableAll: finish")
end

function ExpFestIsConfigured()
    return (EXP_FEST_START ~= nil and EXP_FEST_END ~= nil and type(EXP_FEST_START) == "number" and type(EXP_FEST_END) == "number" and EXP_FEST_START ~= 0 and EXP_FEST_END ~= 0 and EXP_FEST_END > EXP_FEST_START)
end

function ExpFestIsActive()
    local now = os.time()
    return ExpFestIsConfigured() and (now >= EXP_FEST_START and now < EXP_FEST_END)
end

-- Called every time a player logs in or zones
function ExpFestOnZoneIn(player, logging)

    print("ExpFestOnZoneIn: called")
    print(string.format("ExpFestOnZoneIn: logging: %s", tostring(logging)))
    if not ExpFestIsConfigured() then
        -- Minimal overhead if the festival is disabled in the configuration
        print("ExpFestOnZoneIn: event is not configured, stopping")
        return
    end
    
    print("ExpFestOnZoneIn: checking event")
    if ExpFestIsActive() then
        -- Message is only displayed when a user logs in, we don't want to spam it
        -- every time a user zones.
        print("ExpFestOnZoneIn: event it active")
        ExpFestEnable(player, logging)
    else
        -- Don't spam messages on player login when the fest is not active
        print("ExpFestOnZoneIn: event it not active")
        ExpFestDisable(player, false)
    end

    print("ExpFestOnZoneIn: finish")
end

-- Called by the task scheduler on event start / end
function ExpFestTask()

    print("ExpFestTask: called")
    if not ExpFestIsConfigured() then
        -- Should never actually happen but if it does then make sure we
        -- don't screw anything up.
        print ("ExpFestTask: event is not configured, stopping")
        return
    end
    
    print("ExpFestTask: checking event")
    if ExpFestIsActive() then
        print("ExpFestTask: event is active")
        ExpFestEnableAll(true)
    else
        print("ExpFestTask: event is not active")
        ExpFestDisableAll(true)
    end

    print("ExpFestTask: finish")
end

-- Called on server startup
function ExpFestInitialize()
    
    print ("ExpFestInitialize: called")
    if not ExpFestIsConfigured() then
        -- No need to create overhead task if fest is not configured
        print ("ExpFestInitialize: event is not configured, stopping")
        return
    end
    
    print ("ExpFestInitialize: event is configured")
    local now = os.time()
    
    -- Scheduled task actually runs one second later than specified in the configuration
    -- in order to avoid race conditions.
    if EXP_FEST_START > now then
        print (string.format("ExpFestInitialize: adding start task at %i", EXP_FEST_START))
        AddScheduledTask("exp_fest_start", EXP_FEST_START + 1, 1, 1, "scripts/globals/events/exp_fest.lua", "ExpFestTask")
    end
    if EXP_FEST_END > now then
        print (string.format("ExpFestInitialize: adding end task at %i", EXP_FEST_END))
        AddScheduledTask("exp_fest_end", EXP_FEST_END + 1, 1, 1, "scripts/globals/events/exp_fest.lua", "ExpFestTask")
    end

    print ("ExpFestInitialize: finish")
end

-- Unloads the scheduled tasks. Note that players logging in might still
-- get the effect.
function ExpFestUnload()
    print("ExpFestUnload: removing exp fest tasks.")
    RemoveScheduledTask("exp_fest_end")
    RemoveScheduledTask("exp_fest_start")
    print("ExpFestUnload: finish")
end

-- Reinitialize exp fest tasks.
-- Called from the !reloadexpfest command.
-- Note that !reloadglobal settings must be called first
function ExpFestReload()
    print("ExpFestReload: reloading configuration")
    ExpFestUnload()
    ExpFestInitialize()
end
