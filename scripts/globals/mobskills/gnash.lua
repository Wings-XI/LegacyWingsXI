---------------------------------------------------
-- Gnash
-- Deals damage to a single target (Sets HP to 50% for target).
--
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local currentHP = target:getHP()
    local damage = 0

    -- if have more hp then 50%, then reduce
    if (target:getHPP() > 5) then
        damage = currentHP * .5
    else
        -- else you die
        damage = currentHP
    end
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
	target:tryInterruptSpell(mob, 1)
    return dmg
end
