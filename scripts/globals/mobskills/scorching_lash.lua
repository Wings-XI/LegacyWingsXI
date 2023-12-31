---------------------------------------------
--  Scorching Lash
--
--  Description: Deals heavy damage to targets behind user.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Back
--  Notes: Used only if a target with hate is behind them. Conal behind Cerberus.
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (target:isBehind(mob, 48) == false) then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1.3

    if (mob:getID() == 17093004) then -- Nyzul Isle Cerberus
        dmgmod = 0.7
    end

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = 0
    if info.hitslanded > 0 then
        dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    else
        skill:setMsg(tpz.msg.basic.EVADES)
        return
    end
    if skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB then
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
        skill:setMsg(tpz.msg.basic.DAMAGE)
        if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    end
    return dmg
end
