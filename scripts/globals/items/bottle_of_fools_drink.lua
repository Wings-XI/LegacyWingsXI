-----------------------------------------
-- ID: 5435
-- Fools Drink
-- Makes user immune to magical damage
-- ToDo should overwrite fanatics -- to be done once the effects are unique and not reused
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.MAGIC_SHIELD
    -- FEALTY is an imperfect soltion to prevent status ailments as we should stop all enfeebling.
    -- Perhaps spiking MDEF would work
    local effect2 = tpz.effect.FEALTY
    local power = 1
    local duration = 60

    if (target:addStatusEffect(effect, power, 0, duration)) then
        target:messagePublic(tpz.msg.basic.GAINS_EFFECT_OF_ITEM, target, effect, effect)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, target, effect)
    end
    target:addStatusEffectEX(effect2, power, 0, 0, duration)

end