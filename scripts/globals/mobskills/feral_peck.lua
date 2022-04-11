---------------------------------------------
--  Feral Peck
--
--  Description: Deals extreme damage to a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: ???
--  Range: Single Target
--  Notes: Deals a set amount of heavy damage (seems like ~90% of target's current HP) to a single target.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")
require("scripts/globals/msg")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local currentHP = target:getHP()
    local damage = 0

    -- reduce to 10%
    damage = currentHP * .90

    local dmg = MobFinalAdjustments(damage, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, 1) end
    mob:resetEnmity(target)
    return dmg
end
