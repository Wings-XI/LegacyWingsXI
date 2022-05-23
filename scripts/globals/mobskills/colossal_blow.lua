---------------------------------------------------
-- Colossal_Blow
-- Deals damage to a single target.
--
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local currentForm = mob:getLocalVar("form") -- this var is only set for proto-omega

    if (currentForm == 2) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)

    skill:setKnockback(1)

    local currentHP = target:getHP()
    -- remove all by 5%
    local damage = 0

    -- if have more hp then 30%, then reduce to 5%
    if (target:getHPP() > 30) then
        damage = currentHP * .95
    else
        -- else you die
        damage = currentHP
    end
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, 1) end
    mob:resetEnmity(target)
    return dmg
end
