-----------------------------------------
-- ID: 17623
-- Item: Bartholomew's Knife
-- Additional Effect: Water Damage (Shouldn't work on Brigandish Blade but I suck)
----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    local chance = 20

    if (math.random(0,99) >= chance) then
        return 0,0,0
    else
        local dmg = math.random(8,80)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.WATER, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,tpz.magic.ele.WATER,0)
        dmg = adjustForTarget(target,dmg,tpz.magic.ele.WATER)
        dmg = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.WATER,dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return tpz.subEffect.WATER_DAMAGE,message,dmg
    end
end