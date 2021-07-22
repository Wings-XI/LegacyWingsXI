----------------------------------
-- Global Automaton Helpers
----------------------------------
require("scripts/globals/status")
----------------------------------

function updateModPerformance(pet, mod, key, value, cap)
    local previous = pet:getLocalVar(key)
    if previous ~= 0 then
        pet:delMod(mod, previous)
    end
    value = value + value * (pet:getMod(tpz.mod.AUTO_PERFORMANCE_BOOST) / 100)
    if cap then
        value = math.min(value, cap)
    end
    pet:addMod(mod, value)
    pet:setLocalVar(key, value)
end


-- Determines the stat bonus an Automaton shold recieve per maneuver
function getManeuverBonus(player)
    local level
    if (player:getMainJob() == tpz.job.PUP) then
        level = player:getMainLvl()
    else
        level = player:getSubLvl()
    end

    local bonus = 1 + math.floor(level/15)

    return bonus
end
