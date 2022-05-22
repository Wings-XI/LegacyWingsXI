-----------------------------------------
-- ID: 17807
-- Item: Gold Muskateer's Uchigatana (Gld.Msk. Uchigat.) 
-- Additional Effect: Earth Damage
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
        local dmg = math.random(16,33)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.EARTH, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,tpz.magic.ele.EARTH,0)
        dmg = adjustForTarget(target,dmg,tpz.magic.ele.EARTH)
        dmg = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.EARTH,dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return tpz.subEffect.EARTH_DAMAGE,message,dmg
    end
end