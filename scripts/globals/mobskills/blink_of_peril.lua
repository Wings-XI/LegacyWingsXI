---------------------------------------------
--  Blink of Peril
--
--  Description: Deals damage to a single target reducing their HP to 5%. Resets enmity.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Single Target
--  Notes: Gaze Based
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
	if (target:isFacing(mob)) then
        local currentHP = target:getHP()
        -- remove all by 5%
        local damage = 0

        -- if have more hp then 30%, then reduce to 5%
        if (currentHP / target:getMaxHP() > 0.2) then
            damage = currentHP * .95
        else
            -- else you die
            damage = currentHP
        end
        local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
        target:tryInterruptSpell(mob, 1)
        mob:resetEnmity(target)
        return dmg
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
end
