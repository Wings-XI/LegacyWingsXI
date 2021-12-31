-----------------------------------------
-- ID: 5434
-- Fanatic's Drink
-- Makes user immune to physical damage
-- ToDo should overwrite fools
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    -- PHYSICAL_SHIELD is close, but does not catch all TP moves
    -- we will need something stronger here
    local effect = tpz.effect.PHYSICAL_SHIELD
    local power = 1 -- power greater than 2 absorbs
    local duration = 60

    if (target:addStatusEffect(effect, power, 0, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
end