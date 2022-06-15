---------------------------------------------------
-- Double Punch M=6, 2 (still guessing here)
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 56
    local ele = tpz.damageType.FIRE
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 2
    local accmod = 5
    local dmgmod = 6 * coe * (1 + 0.3*skill:getTP()/3000)
    local dmgmodsubsequent = 2 * coe * (1 + 0.3*skill:getTP()/3000)

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, TP_NO_EFFECT,1,2,3)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.H2H, numhits)
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.H2H)
    target:updateEnmityFromDamage(pet, totaldamage)

    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
