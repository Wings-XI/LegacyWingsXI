-----------------------------------
-- Attachment: Scope II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------
-- per http://wiki.ffo.jp/html/8063.html should be enhanced by optic fiber

function onEquip(pet)
    onUpdate(pet, 0)
end

function onUnequip(pet)
    updateModPerformance(pet, tpz.mod.RACC, 'scope_ii_mod', 0)
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    if maneuvers == 0 then
        updateModPerformance(pet, tpz.mod.RACC, 'scope_ii_mod', 20)
    elseif maneuvers == 1 then
        updateModPerformance(pet, tpz.mod.RACC, 'scope_ii_mod', 10)
    elseif maneuvers == 2 then
        updateModPerformance(pet, tpz.mod.RACC, 'scope_ii_mod', 10)
    elseif maneuvers == 3 then
        updateModPerformance(pet, tpz.mod.RACC, 'scope_ii_mod', 10)
    end
end
