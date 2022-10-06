---------------------------------------------------
-- Rush M=5, 2
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
    local ele = tpz.damageType.ICE
    local params = {}
    params.str_wsc = 0.15 params.dex_wsc = 0.15 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    local numhits = 5
    local accmod = 0 + math.floor(8*skill:getTP()/3000)
    local dmgmod = 5
    local dmgmodsubsequent = 2
    local totaldamage = 0

    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, TP_NO_EFFECT, 1, 2, 3, 0, params)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)

    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)
    
    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
