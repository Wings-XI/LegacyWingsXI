---------------------------------------------
--  Wind Shear
--
--  Description: Deals damage to enemies within an area of effect. Additional effect: Knockback
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 10' radial
--  Notes: The knockback is rather severe. Vulpangue uses an enhanced version that inflicts Weight.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .8
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
