-----------------------------------------
-- ID: 15842
-- Teleport ring: Pashhow
-- Enchantment: "Recall-Pashhow"
-----------------------------------------

require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasKeyItem(tpz.ki.PASHHOW_GATE_CRYSTAL) == false) then
        result = 445
    end
    return result
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.PASHH, 0, 2)
end