---------------------------------------------
--  Cutpurse
--  Description: Unequips a random piece of equipment.
--  Type: Enfeebling
--  Ignore Shadows, Single target
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if not target:isPC() then return 1 end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)

    local slot = 0
    local occupiedSlots = { }
    
    while slot < 16 do
        local item = target:getEquippedItem(slot)
        if item ~= nil then occupiedSlots[#occupiedSlots + 1] = slot end
        slot = slot + 1
    end
    
    if #occupiedSlots == 0 then return 0 end
    
    local pickedSlot = occupiedSlots[math.random(1,#occupiedSlots)]
    target:unequipItem(pickedSlot)
    if pickedSlot == tpz.slot.MAIN then target:unequipItem(tpz.slot.SUB) end -- per wiki
    
    return 0
end
