---------------------------------------------------
-- Whirl of Rage
-- Delivers an area attack that stuns enemies. Damage varies with TP.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded*math.random(2, 3))

    local typeEffect = tpz.effect.STUN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)
    if mob:getZone():getType() == tpz.zoneType.DYNAMIS then
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.SILENCE, 1, 0, math.random(60, 120))
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.WEIGHT, 25, 0, math.random(30, 45))
    end

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
