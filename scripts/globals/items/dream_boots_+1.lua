-----------------------------------------
-- ID: 15753
-- Item: Dream Boots +1
-- Enchantment: Sneak
-- Duration: 3 Mins 20 Secs
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (not target:hasStatusEffect(tpz.effect.SNEAK)) then
        local duration = 200 + target:getMod(tpz.mod.SNEAK_DURATION)
        target:addStatusEffect(tpz.effect.SNEAK, 1, 10, math.floor(duration * SNEAK_INVIS_DURATION_MULTIPLIER))
    end
end
