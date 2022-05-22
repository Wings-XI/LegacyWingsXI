-----------------------------------------
-- ID: 17965
-- Item: Sirocco Axe
-- Additional Effect: Wind Damage
-- Gweivyth
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    local chance = 10

    if (math.random(0,99) >= chance) then
        return 0,0,0
    else
        local dmg = math.random(5,12)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.WIND, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,tpz.magic.ele.WIND,0)
        dmg = adjustForTarget(target,dmg,tpz.magic.ele.WIND)
        dmg = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.WIND,dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return tpz.subEffect.WIND_DAMAGE,message,dmg
    end
end