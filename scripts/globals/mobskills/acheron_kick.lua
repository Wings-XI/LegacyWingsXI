---------------------------------------------
--  Acheron Kick
--
--  Description: Physical Cone Attack damage behind user.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Back
--  Notes: Used only if a target with hate is behind them, conal. 
--  Dark Ixion CAN turn around to use this move on anyone with hate, regardless of their original position or even distance.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if  mob:AnimationSub() == 1 or mob:getLocalVar("charging") == 1 then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- Dark Ixion doesn't hit himself with AoE mobskills
    if target:getPool() ~= nil and target:getPool() == 915 then
        skill:setMsg(0)
        return
    end
    local numhits = math.random(2,3)
    local accmod = 1
    local dmgmod = 1

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
        skill:setMsg(tpz.msg.basic.HIT_DMG)
        target:tryInterruptSpell(mob, info.hitslanded)
    end
    return dmg
end
