-----------------------------------------
-- ID: 5391
-- Soldier's Drink
-- Increases damage by 50% - lasts one attack/spell/weaponskill
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.SOLDIERS_DRINK
    local power = 1
    local duration = 60

    target:addStatusEffectEx(effect, tpz.effect.BOOST, power, 0, duration)
end