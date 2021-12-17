---------------------------------------------
--  Pinecone Bomb
--
--  Description: Single target damage with sleep.
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)

    if mob:getID() == 16932881 or mob:getID() == 17555863 then
        dmg = dmg * 0.8
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    else
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
        local typeEffect = tpz.effect.SLEEP_I
        MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)
    end


	if dmg > 0 and skill:getMsg() ~= 31 then
        target:tryInterruptSpell(mob, info.hitslanded)
    end

    return dmg
end
