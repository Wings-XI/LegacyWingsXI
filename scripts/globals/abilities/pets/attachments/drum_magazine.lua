-----------------------------------
-- Attachment: Drum Magazine
-----------------------------------
require("scripts/globals/status")
-----------------------------------
-- http://wiki.ffo.jp/html/8882.html

function onEquip(pet)
    pet:addMod(tpz.mod.RACC, -20)
    pet:addMod(tpz.mod.SNAP_SHOT, 3)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.RACC, -20)
    pet:delMod(tpz.mod.SNAP_SHOT, 3)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.SNAP_SHOT, 3)
        pet:addMod(tpz.mod.RACC, -20)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.SNAP_SHOT, 3)
        pet:addMod(tpz.mod.RACC, -30)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.SNAP_SHOT, 2)
        pet:addMod(tpz.mod.RACC, -30)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.SNAP_SHOT, 3)
        pet:delMod(tpz.mod.RACC, -20)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.SNAP_SHOT, 3)
        pet:delMod(tpz.mod.RACC, -30)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.SNAP_SHOT, 2)
        pet:delMod(tpz.mod.RACC, -30)
    end
end
