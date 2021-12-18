-----------------------------------------
-- ID: 17599
-- Item: Kabrakan's Axe
-- Additional Effect: Slow
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 5

    if VanadielDayOfTheWeek() == tpz.day.EARTHSDAY then
        chance = 50
    end    

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.EARTH, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(tpz.effect.SLOW, 1500, 0, 60)
        return tpz.subEffect.PARALYSIS, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.SLOW -- theres no subeffect animation for slow, will just use paralysis
    end
end