---------------------------------------------
--  Tourbillion
--
--  Description: Delivers an area attack. Additional effect duration varies with TP. Additional effect: Weakens defense.
--  Type: Physical
--  Shadow per hit
--  Range: Unknown range
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() ~= 0) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1.5
    if (mob:getID() == 17093002) then -- Nyzul Isle Khimaira
        dmgmod = 1
    end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = 0
    local duration = 20 * (skill:getTP() / 1000)

    if info.hitslanded > 0 then
        dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    else
        skill:setMsg(tpz.msg.basic.EVADES)
        return
    end
    if skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB then
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.DEFENSE_DOWN, 20, 0, duration)
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
        skill:setMsg(tpz.msg.basic.HIT_DMG)
        if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    end

    return dmg
end
