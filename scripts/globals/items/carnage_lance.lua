-----------------------------------------
-- ID: 16881
-- Item: Carnage Lance
-- Additional effect: HP Drain
-- Gweivyth
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
        local drain = math.random(26,39)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        -- drain = addBonusesAbility(player, tpz.magic.ele.DARK, target, drain, params)
        drain = drain * applyResistanceAddEffect(player,target,tpz.magic.ele.DARK,0)
        drain = adjustForTarget(target,drain,tpz.magic.ele.DARK)
        drain = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.DARK,drain)

        return tpz.subEffect.HP_DRAIN, tpz.msg.basic.ADD_EFFECT_HP_DRAIN, player:addHP(drain)
    end
end