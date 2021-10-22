---------------------------------------------
-- Blazing Angon
-- Deals heavy Fire damage to enemies within a wide conal area
-- Used exclusively by Lancelord Gahell Ja below 25% and Searing Vogaal Ja in Besieged
-- Additional Effect: Defense Down (50%) and Knockback (3')
-- TODO: Currently set to Radial AOE as we can't set wide conal
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getHPP() > 25 then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1.2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, tpz.magic.ele.FIRE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 50, 0, 60)
    return dmg
end