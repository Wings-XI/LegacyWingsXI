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
    local mob = target:getStat(tpz.mod.MND)
    local res = 1 - (mnd / mob)

    if res < 0 then
        res = 0
    end

    --Updated Formula based on AE Data taken at multiple MND levels
    local dmg = math.floor((0.0001*mnd^3)-(0.0086*mnd^2)+(0.5755*mnd)+2.2433)

    --Capping DMG at 60, which is highest seen with +5 variance at 65.
    if dmg > 60 then
        dmg = 60
    end

    -- Adds Variance seen in data
    dmg = dmg + math.random(-5,5)

    -- Min AE DMG = 10 (Pre resist)
    if (dmg < 10) then
        dmg = 10
    end

    -- Resistance check vs mob's MND
    if math.random(0,1) < res then
        dmg = math.floor(dmg * (math.random(1,5)/10))
    end

    -- Making Min dmg 1 post resist due to errors if 0
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