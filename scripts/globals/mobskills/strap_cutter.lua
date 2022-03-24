---------------------------------------------
-- Strap Cutter
-- Description: Removes and disables several random equipment slots for a period of time.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numberToBlock = math.random(3,5) -- bg-wiki claims 3-5
    local equipmentToBlock = 0
    -- Need a list that corresponds to the range from tpz.slot.MAIN to tpz.slot.BACK - but mutable without consequence
    local equipmentSlots = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
    for i=1, numberToBlock do
        index = math.random(#equipmentSlots)
        slot = equipmentSlots[index]
        table.remove(equipmentSlots, index)
        target:unequipItem(slot)
        equipmentToBlock = equipmentToBlock + bit.lshift(1, slot)
    end
    target:addStatusEffectEx(tpz.effect.ENCUMBRANCE_I, tpz.effect.ENCUMBRANCE_I, equipmentToBlock, 0, 60) -- verify this has an icon
    skill:setMsg(tpz.msg.basic.NONE)
end
