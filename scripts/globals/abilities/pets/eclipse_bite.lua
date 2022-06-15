---------------------------------------------------
-- Eclipse Bite M=8 subsequent hits M=2
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 109
    local ele = tpz.damageType.DARK
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 3
    local accmod = 10
    local dmgmod = 8 * coe * (1 + 0.4*skill:getTP()/3000)
    local dmgmodsubsequent = 2 * coe * (1 + 0.4*skill:getTP()/3000)
    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, numhits)
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    target:updateEnmityFromDamage(pet, totaldamage)

    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
