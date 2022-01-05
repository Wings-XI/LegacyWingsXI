-----------------------------------------
-- ID: 5432
-- Item: Dusty Ether
-- Item Effect: Instantly restores 150 MP
-----------------------------------------
require("scripts/globals/msg")

function onItemCheck(target)
    local result = 0
    local mMP = target:getMaxMP()
    local cMP = target:getMP()

    if mMP == cMP then
        result = 56 -- Does not let player use item if their mp is full
    end

    return result
end

function onItemUse(target)
    target:addMP(150)
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, target, 150)
end
