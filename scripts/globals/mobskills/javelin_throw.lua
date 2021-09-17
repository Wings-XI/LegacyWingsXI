---------------------------------------------
--
-- Javelin throw (spear wielding Mamool Ja only!)
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getMainJob() == tpz.job.DRG then
        if mob:getHPP() <= 50 then
            -- If animationSub is 1, the mob has already lost his weapeon and cant do this TP attack.
            if mob:AnimationSub() == 0 then
                return 0
            end
        end
    end
    
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)

    mob:timer(2000, function(mob) mob:AnimationSub(1) end) -- Mob loses his weapeon after using this tp attack
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
