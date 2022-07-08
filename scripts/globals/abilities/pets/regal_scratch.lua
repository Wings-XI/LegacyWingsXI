---------------------------------------------------
-- M=3,1
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    --skill:setAnim(10)
    local mpCost = 5
    local ele = tpz.damageType.LIGHT
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 3
    local accmod = 1 + math.floor(20*skill:getTP()/3000)
    local dmgmod = (3 + pet:getMainLvl()/15) * coe
    local dmgmodsubsequent = (1 + 0) * coe

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = AvatarFinalAdjustments(damage.dmg,pet,skill,target,tpz.attackType.PHYSICAL,tpz.damageType.SLASHING,numhits)
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    target:updateEnmityFromDamage(pet,totaldamage)
    
    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
