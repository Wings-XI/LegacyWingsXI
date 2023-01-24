-----------------------------------------
-- ID: 18948
-- Item: Enforcer
-- Additional effect: MP Drain
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    local chance = 25

    if (math.random(0,99) >= chance or target:isUndead()) then
        return 0,0,0
    else
        local aspir = math.random(6,35)
        aspir = aspir * applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0)
        aspir = adjustForTarget(target, aspir, tpz.magic.ele.DARK)
        if (aspir < 0) then
            aspir = 0
        end

        aspir = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.DARK, aspir)
        return tpz.subEffect.MP_DRAIN, tpz.msg.basic.ADD_EFFECT_MP_DRAIN, player:addMP(aspir)
    end
end
