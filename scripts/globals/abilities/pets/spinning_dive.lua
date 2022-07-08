---------------------------------------------------
-- Spinning Dive M=12
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 164
    local ele = tpz.damageType.WATER
    local params = {}
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    local numhits = 1
    local accmod = 20
    local dmgmod = 12
    local totaldamage = 0

    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3, 0, params)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, numhits)

    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    target:updateEnmityFromDamage(pet, totaldamage)
    
    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
