---------------------------------------------------
-- Double Punch M=6, 2 (still guessing here)
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 56
    local ele = tpz.damageType.FIRE
    local params = {}
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    local numhits = 2
    local accmod = 5
    local dmgmod = 6
    local dmgmodsubsequent = 2
    local totaldamage = 0

    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, TP_NO_EFFECT, 1, 2, 3, 0, params)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.H2H, numhits)

    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.H2H)
    target:updateEnmityFromDamage(pet, totaldamage)

    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
