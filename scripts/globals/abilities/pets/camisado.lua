---------------------------------------------------
-- Camisado M=3.5
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
    local mpCost = 20
    local ele = tpz.damageType.DARK
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 1
    local accmod = -5
    local dmgmod = 3.5 * coe

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)
    
    if totaldamage > 0 then
        target:addStatusEffect(tpz.effect.STUN,1,0,1) -- knockback workaround for now
    end
    
    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
