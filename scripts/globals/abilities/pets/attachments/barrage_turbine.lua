-----------------------------------
-- Attachment: Barrage Turbine
-----------------------------------
require("scripts/globals/status")

function onEquip(pet)
    pet:addMod(tpz.mod.AUTOMATON_CAN_BARRAGE, 1)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.AUTOMATON_CAN_BARRAGE, 1)
end

function onManeuverGain(pet,maneuvers)
    
end

function onManeuverLose(pet,maneuvers)
    
end
