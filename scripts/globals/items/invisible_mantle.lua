-----------------------------------------
-- ID: 13685
-- Item: Invisible Mantle
-- Item Effect: gives invisible
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (target:hasStatusEffect(tpz.effect.INVISIBLE)) then
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    else
        local duration = 180 + target:getMod(tpz.mod.INVISIBLE_DURATION)
        target:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
    end
end
