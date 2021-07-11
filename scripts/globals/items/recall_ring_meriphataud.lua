-----------------------------------------
-- ID: 15843
-- Teleport ring: Meriph
-- Enchantment: "Recall-Meriph"
-----------------------------------------

require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasKeyItem(tpz.ki.MERIPHATAUD_GATE_CRYSTAL) == false) then
        result = 445
    end
    return result
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.MERIPH, 0, 2)
end
