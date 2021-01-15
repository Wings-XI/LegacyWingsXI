-----------------------------------
-- Attachment: Tactical Processor
-- Not enough information to accurately recreate!
-- Also, not implemented, increased tendency to overload prior to 2015!
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 500) -- -0.5s
    pet:addMod(tpz.mod.BURDEN_DECAY_IGNORE_CHANCE, 40)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 500)
    pet:delMod(tpz.mod.BURDEN_DECAY_IGNORE_CHANCE, 40)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 200) -- -0.70s ?
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 150) -- -0.85s ?
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 300) -- -1.15s
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 200)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 150)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 300)
    end
end
