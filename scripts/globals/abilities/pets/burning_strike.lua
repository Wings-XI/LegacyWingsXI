---------------------------------------------------
-- Burning Strike M = 6?
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 48
    local ele = tpz.damageType.FIRE
    local coe = getAvatarEcosystemCoefficient(target, ele)
    local numhits = 1
    local accmod = 3 + math.floor(9*skill:getTP()/3000)
    local dmgmod = 6 * coe

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, 0, TP_NO_EFFECT, 1, 2, 3)
    --get resist multiplier (1x if no resist)
    local resist = applyPlayerResistance(pet, -1, target, pet:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), tpz.skill.ELEMENTAL_MAGIC, tpz.magic.ele.FIRE)
    --get the resisted damage
    damage.dmg = damage.dmg*(resist+0.2)
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = mobAddBonuses(pet, nil, target, damage.dmg, 1)
    totaldamage = AvatarFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, numhits)
    target:takeDamage(totaldamage, pet, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    target:updateEnmityFromDamage(pet, totaldamage)
    
    pet:getMaster():addMP(-mpCost)
    return totaldamage
end
