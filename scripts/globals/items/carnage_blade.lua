-----------------------------------------
-- ID: 16827
-- Item: Carnage Blade
-- Additional effect: HP Drain
-- Kyuu
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    local chance = 15

    if (math.random(0,99) >= chance or target:isUndead()) then
        return 0,0,0
    else
        local drain = damage * (math.random(15,50) / 100)
        local halfDamage = damage / 2
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        --drain = addBonusesAbility(player, tpz.magic.ele.DARK, target, drain, params)
        drain = drain * applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 0)
        drain = adjustForTarget(target, drain, tpz.magic.ele.DARK)
        if (drain < 0) then
            drain = 0
        end
        if (drain > halfDamage) then
            drain = halfDamage
        end
        drain = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.DARK, drain)
        return tpz.subEffect.HP_DRAIN, tpz.msg.basic.ADD_EFFECT_HP_DRAIN, player:addHP(drain)
    end
end
