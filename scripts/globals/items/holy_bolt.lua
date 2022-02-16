-----------------------------------------
-- ID: 18153
-- Item: Holy Bolt
-- Additional Effect: Light Damage
-- Bolt dmg is affected by light/dark staves and Chatoyant
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local mnd = player:getStat(tpz.mod.MND)
    local dmg = math.floor(math.log(mnd, 1.1) + 10)
    if (dmg < 1) then
        dmg = 1
    end
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(player, tpz.magic.ele.LIGHT, target, dmg, params)
    dmg = adjustForTarget(target, dmg, tpz.magic.ele.LIGHT)
    dmg = finalMagicNonSpellAdjustments(player, target, tpz.magic.ele.LIGHT, dmg)
    return tpz.subEffect.LIGHT_DAMAGE, tpz.msg.basic.ADD_EFFECT_DMG, dmg
end