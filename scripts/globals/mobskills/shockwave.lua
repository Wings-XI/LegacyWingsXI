---------------------------------------------
-- Shockwave
-- Delivers an area of effect attack. Sleeps enemies. Duration of effect varies with TP.
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 4
    local dmgmod = 1.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    if (dmg > 0 and target:hasStatusEffect(tpz.effect.SLEEP_I) == false) then
        local duration = 60 * applyResistanceAddEffect(mob, target, tpz.magic.ele.DARK, 0)
        target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, duration)
    end
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
