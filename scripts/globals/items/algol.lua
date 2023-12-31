-----------------------------------------
-- ID: 18385
-- Item: Algol
-- Additional Effect: Fire Damage
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local dmg = math.random(23, 30) -- dmg mod as per BG
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(player, tpz.magic.ele.FIRE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(player, target, tpz.magic.ele.FIRE, 0)
    dmg = adjustForTarget(target, dmg, tpz.magic.ele.FIRE)
    dmg = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.FIRE, dmg)

    local message = tpz.msg.basic.ADD_EFFECT_DMG
    if (dmg < 0) then
        message = tpz.msg.basic.ADD_EFFECT_HEAL
        dmg = -dmg
    end

    local proc = math.random() < 0.3 -- 30% chance to proc
    if (proc) then
        return tpz.subEffect.FIRE_DAMAGE, message, dmg
    end
end
