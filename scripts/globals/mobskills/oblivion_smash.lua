---------------------------------------------
-- Oblivion Smash
--
-- Description: Deals damage to players within area of effect and inflicts blind, silence, bind, and weight.
-- Type: Physical
-- Utsusemi/Blink absorb:  2-3 shadows
-- Range: Unknown radial
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 1.5, 2)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    if info.hitslanded > 0 then
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.BLINDNESS, 20, 0, 120)
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.SILENCE, 0, 0, 120)
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.BIND, 0, 0, 120)
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.WEIGHT, 50, 0, 120)
    end

    if info.hitslanded > 0 and mob:getHPP() <= 25 and skill:getID() == 1133 then
        skill:setMsg(tpz.msg.basic.FALL_TO_GROUND)
        target:setHP(0)
        return 0 -- insta death
    else
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
        if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
        return dmg
    end
end
