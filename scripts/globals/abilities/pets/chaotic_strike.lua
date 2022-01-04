---------------------------------------------------
-- Chaotic Strike M=9 , 2
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/magic")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)

    local ele = tpz.damageType.LIGHTNING
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 3
    local accmod = 1
    local dmgmod = 5 * coe -- 9 * coe is original formula - return once smn skills audited for correctness
    local dmgmodsubsequent = 2 * coe
    local critmod = 1 + math.floor(20*skill:getTP()/3000)

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, TP_NO_EFFECT, 1, 2, 3, critmod)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)

    local dDEX = pet:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.DEX)
    local bonus = dDEX
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet)
    end

    local resist = applyResistanceAbility(pet,target,tpz.magic.element.LIGHTNING,tpz.skill.ENFEEBLING_MAGIC,bonus)
    local duration = math.ceil(5 * resist * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
    
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if resist >= 0.25 and totaldamage > 0 then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
        end
    end

    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)
    return totaldamage
end
