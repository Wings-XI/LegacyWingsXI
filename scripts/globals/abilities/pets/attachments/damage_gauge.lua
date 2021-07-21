-----------------------------------
-- Attachment: Damage Gauge
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

local function updateMod(pet, mod, key, value)
    -- a setMod with independent state
    local previous = pet:getLocalVar(key)
    if previous ~= 0 then
        pet:delMod(mod, previous)
    end
    pet:addMod(mod, value)
    pet:setLocalVar(key, value)
end

local function onUpdate(pet, maneuvers)
    -- Damage Guage / Optic Fiber interaction is different from the other attachments affected by Optic Fiber
    local opticMod = pet:getMod(tpz.mod.AUTO_PERFORMANCE_BOOST) > 0.0 and 1.0 or 0.0

    if maneuvers == 0 then
        updateMod(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 20 + opticMod * 0)
    elseif maneuvers == 1 then
        updateMod(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 30 + opticMod * 10)
    elseif maneuvers == 2 then
        updateMod(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 30 + opticMod * 10)
    elseif maneuvers == 3 then
        updateMod(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 15 + opticMod * 0)
    end
end

function onEquip(pet)
    pet:setLocalVar("damagegauge", 1)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateMod(pet, tpz.mod.AUTO_HEALING_THRESHOLD, 'damage_gauge_threshold', 0)
    pet:setLocalVar("damagegauge", 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end
