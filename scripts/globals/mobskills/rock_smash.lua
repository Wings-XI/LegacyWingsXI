---------------------------------------------
--  Rock Smash
--
--  Description: Damages a single target. Additional effect: Petrification
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes: Requires No Weapon or Broken Weapon
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
   if mob:AnimationSub() == 1 or mob:getMainJob() == tpz.job.MNK or mob:getMainJob() == tpz.job.PUP or mob:getFamily() == 91 then
        return 0
   else 
        return 1
   end

end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 2
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    local typeEffect = tpz.effect.PETRIFICATION
    local power = math.random(25, 40) + mob:getMainLvl()/3

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 50, 0, power)


	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
