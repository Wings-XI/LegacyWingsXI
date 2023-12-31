-----------------------------------------
-- ID: 16720
-- Item: Plantbane
-- Additional Effect: Fire Damage vs. Plants
-- Gweivyth
----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
function onAdditionalEffect(player,target,damage)
    local chance = 10

	if math.random(100) >= chance or target:getSystem() ~= tpz.ecosystem.PLANTOID then
        return 0,0,0
    else
        local dmg = math.random(10,20)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.FIRE, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,tpz.magic.ele.FIRE,0)
        dmg = adjustForTarget(target,dmg,tpz.magic.ele.FIRE)
        dmg = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.FIRE,dmg)

        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return tpz.subEffect.FIRE_DAMAGE,message,dmg
    end
end