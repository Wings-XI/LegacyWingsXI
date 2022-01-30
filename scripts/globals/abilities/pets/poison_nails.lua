---------------------------------------------------
-- Poison Nails  M=3? guess
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local ele = tpz.damageType.LIGHT
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 1
    local accmod = 1 + math.floor(7*skill:getTP()/3000)
    local dmgmod = 2.8 * coe

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)

    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, numhits)

    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    target:updateEnmityFromDamage(pet, totaldamage)
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.POISONRES) < 100 then
        if (AvatarPhysicalHit(skill, totalDamage) and target:hasStatusEffect(tpz.effect.POISON) == false) then
            target:addStatusEffect(tpz.effect.POISON, 1, 3, 60)
        end
    end

    return totaldamage
end
