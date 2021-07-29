require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------------------
-- Instance functionality
-----------------------------------------------

--[[
    [InitiatingZoneId] = {
        {bit, instanceIdFromInstanceList, requiredItemToTrade} -- TODO decide if bit is required (i.e. decide if this class will responsible for populating entrance dialog selections for players).  Research if trade is used for any instances
    },
--]]
-- Note: InstanceZoneId vs InitiatingZoneId - using InitiatingZoneId creates some duplicate entries for Sandworm as Sandworm can initiate the same instance via different zones
-- However using InstanceZoneId requires translation between known information and configured mappings.
-- e.g. A player initiation in FORT_KARUGO_NARUGO_S is known informaiton.  That the instance attempting to be initiated takes place in GHOYUS_REVERIE can only be assumed.

-- TODO: Migrate all existing instances to use this class to enable/disable instances
local instances = {
    [tpz.zone.FORT_KARUGO_NARUGO_S] =
    {
        --{ 0,   96,    0},   -- A Manifest Problem (WotG Mission-Quest)
    },
}


-----------------------------------------------
-- check requirements for registrant and allies
-- TODO: As instances are added to this control, add their Reqs
-----------------------------------------------
function instanceCheckReqs(player, instanceId, isInitiator)
    local registerRequirements = {
        
        [  96] = function() return ( player:hasKeyItem(tpz.ki.FORT_KEY) ) end, -- A Manifest Problem (WotG Mission-Quest)
    }

   -- Requirements to enter a battlefield already registered by a party member
    local enterRequirements = {
        [  96] = function() return ( player:hasKeyItem(tpz.ki.FORT_KEY) or player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_MANIFEST_PROBLEM) == QUEST_COMPLETED ) end, -- A Manifest Problem (WotG Mission-Quest)
    }

    local requirement = (isInitiator == true) and registerRequirements[instanceId] or enterRequirements[instanceId]
    if not requirement then
        return true
    elseif requirement() then
        return true
    else
        return false
    end
end

function VerfyInstanceForPlayer(player, instanceId, isInitiator)
    -- see if the instance is enabled (exists in the mapping)
    -- see if player meets reqs
    local possibleInstances = instances[player:getZoneID()]
    if possibleInstances == nil then
        return false -- no instances in the zone enabled
    end
    for k, instance in pairs(possibleInstances) do
        if instanceId == instance[2] then 
            return instanceCheckReqs(player, instanceId, isInitiator)
        end
    end

    -- Instance requested was not in the list of enabled instances
    return false
end

function updateInstanceTime(instance, elapsed, texttable)
    local players = instance:getChars()
    local lastTimeUpdate = instance:getLastTimeUpdate()
    local remainingTimeLimit = (instance:getTimeLimit()) * 60 - (elapsed / 1000)
    local wipeTime = instance:getWipeTime()
    local message = 0

    if (remainingTimeLimit < 0) then
        instance:fail()
        return
    end

    if (wipeTime == 0) then
        local wipe = true
        for i, v in pairs(players) do
            if v:getHP() ~= 0 then
                wipe = false
                break
            end
        end
        if (wipe) then
            for i, v in pairs(players) do
                v:messageSpecial(texttable.PARTY_FALLEN, 3)
            end
            instance:setWipeTime(elapsed)
        end
    else
        if (elapsed - wipeTime) / 1000 > 180 then
            instance:fail()
            return
        else
            for i, v in pairs(players) do
                if v:getHP() ~= 0 then
                    instance:setWipeTime(0)
                    break
                end
            end
        end
    end

    if (lastTimeUpdate == 0 and remainingTimeLimit < 600) then
        message = 600
    elseif (lastTimeUpdate == 600 and remainingTimeLimit < 300) then
        message = 300
    elseif (lastTimeUpdate == 300 and remainingTimeLimit < 60) then
        message = 60
    elseif (lastTimeUpdate == 60 and remainingTimeLimit < 30) then
        message = 30
    elseif (lastTimeUpdate == 30 and remainingTimeLimit < 10) then
        message = 10
    end

    if (message ~= 0) then
        for i, v in pairs(players) do
            if (remainingTimeLimit >= 60) then
                v:messageSpecial(texttable.TIME_REMAINING_MINUTES, remainingTimeLimit / 60)
            else
                v:messageSpecial(texttable.TIME_REMAINING_SECONDS, remainingTimeLimit)
            end
        end
        instance:setLastTimeUpdate(message)
    end
end
