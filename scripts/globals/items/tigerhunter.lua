-----------------------------------------
-- ID: 16672
-- Item: Tigerhunter
-- Additional Effect: Paralyzses Tigers

----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    if (target:getFamily() == 242) then
        local chance = 10
        if math.random(100) <= chance and applyResistanceAddEffect(player,target,tpz.magic.ele.ICE,0) > 0.5 then
            target:addStatusEffect(tpz.effect.PARALYSIS, 10, 0, 30)
            return tpz.subEffect.PARALYSIS, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.PARALYSIS
        end
    end
    return 0, 0, 0
end

