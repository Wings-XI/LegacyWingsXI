-----------------------------------------
-- ID: 5396
-- Shepherd's Drink
-- Instantly restores a pet's HP
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    local pet = target:getPet()
    if pet and (pet:getHP() ~= pet:getMaxHP())  then
        return 0
    end
    return tpz.msg.basic.ITEM_UNABLE_TO_USE
end

function onItemUse(target)
    local pet = target:getPet()

    if pet and (pet:getHP() ~= pet:getMaxHP())  then
        local healingAmount = pet:getMaxHP() - pet:getHP()
        pet:setHP(pet:getMaxHP())
        target:messagePublic(tpz.msg.basic.RECOVERS_HP, pet, 0, healingAmount)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target)
    end
end