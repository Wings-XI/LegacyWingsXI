-----------------------------------
-- Area: Nyzul Isle Investigation
--  Mob: Archaic Gears
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Nyzul_Isle/IDs")

local function applyPenalty(instance)
    local chars = instance:getChars()
    local penalty = instance:getLocalVar("Nyzul_GearPenalty")
    local message
    local param = 0
    
    if (penalty == 1) then -- token reduction
        message = ID.text.POTENTIAL_TOKENS_REDUCED
        param = 0
        local tokenPenalty = instance:getLocalVar("Nyzul_TokenPenalty")
        instance:setLocalVar("Nyzul_TokenPenalty", tokenPenalty + 100)
    elseif (penalty == 2) then -- time reduction
        message = ID.text.TIME_REDUCED_BY_MINUTES
        param = 1
        local timePenalty = instance:getLocalVar("Nyzul_TimePenalty")
        instance:setLocalVar("Nyzul_TimePenalty", timePenalty + 1)
    else -- Pathos Debuff
        message = ID.text.SECURITY_FIELD_MALFUNCTION
        addPenaltyPathos(instance)
    end
    for _,char in pairs(chars) do
        char:messageSpecial(message, param)
    end
end

function onMobInitialize(mob)
    mob:addListener("ON_AGGRO_PLAYER", "GEARS_AGGRO", function(mob)
        local instance = mob:getInstance()
        if (instance:getLocalVar("Nyzul_SubObjective") == 2) then
            if (mob:getLocalVar("GearAggro") == 0) then
                mob:setLocalVar("GearAggro", 1)
                applyPenalty(instance)
            end
        end
    end)
end

function onMobDisengage(mob)
    mob:setLocalVar("GearAggro", 0)
end

function onMobDeath(mob, player, isKiller)
    local instance = mob:getInstance()
    if (isKiller) and (instance:getLocalVar("Nyzul_SubObjective") == 1) then
        applyPenalty(instance)
    end
end

