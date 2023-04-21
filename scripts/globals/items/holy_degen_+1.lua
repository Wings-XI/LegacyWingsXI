-----------------------------------------
-- ID: 16817
-- Item: holy_degen_+1
-- Additional Effect: Light Damage
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    local chance = 15

    if (math.random(0,99) >= chance) then
        return 0,0,0
    else
        local dmg = math.random(chance,chance*2)
        local dmgType = tpz.magic.ele.LIGHT
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, dmgType, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,dmgType,0)
        dmg = adjustForTarget(target,dmg,dmgType)
        dmg = finalMagicNonSpellAdjustments(player,target,dmgType,dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return dmgType,message,dmg
    end
end