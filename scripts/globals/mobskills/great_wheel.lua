---------------------------------------------
--  Great Wheel
--
--  Description: Damages enemies in an area of effect. Additional effect: Enmity Reset + Knockback
--  Type: Physical
--  Wipes Shadows
--  Range: Melee range radial
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 2
    local accmod = 1
    local dmgmod = 1.1
    if mob:getID() == 16924679 then -- Apoc Nigh Damage Change
        -- Should deal around 300-350.
        -- https://www.youtube.com/watch?v=mG-qyhGOqNY&ab_channel=Smackdownbob
        dmgmod = 2.5
    end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_2_SHADOW)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    mob:resetEnmity(target)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
