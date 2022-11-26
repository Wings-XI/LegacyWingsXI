---------------------------------------------------
-- Deathgnash
-- Deals damage to a single target (Sets HP to 1 for target).
--
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local hpp = mob:getHPP()
    if mob:getID() == 16998874 then
        if mob:getLocalVar("Phase") == 1 then
            if hpp <= 50 then
                return 0
            else
                return 1
            end
        else
            return 1
        end
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local currentHP = target:getHP()
    local damage = 0

    -- if have more hp then 5%, then reduce
    if (target:getHPP() > 5) then
        damage = currentHP - 1
    else
        -- else you die
        damage = currentHP
    end
    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
	target:tryInterruptSpell(mob, 1)
    mob:resetEnmity(target)
    return dmg
end