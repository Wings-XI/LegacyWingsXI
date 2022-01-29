-----------------------------------------
-- ID: 17439
-- Item: Leviathan's Rod
-- Additional Effect: Water Damage
----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    local chance = 15

    if (VanadielDayOfTheWeek() == tpz.day.WATERDAY) then
        chance = chance+6
    end

    if (math.random(0,99) >= chance) then
        return 0,0,0
    else
        local dmg = math.random(29,39)
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
        end

        return tpz.subEffect.FIRE_DAMAGE,message,dmg
    end
end