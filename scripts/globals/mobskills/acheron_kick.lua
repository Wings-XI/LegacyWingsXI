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
    end
    if (target:isBehind(mob, 48) == false) then
        local Mx = mob:getXPos()
        local Mz = mob:getZPos()
        local My = mob:getYPos()
        local Tx = target:getXPos()
        local Tz = target:getZPos()
        local Dx = Tx - Mx
        local Dz = Tz - Mz
        local away = {x = Mx-Dx, y = My, z = Mz-Dz}
        mob:lookAt(away)       
    end
    
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = math.random(2,3)
    local accmod = 1
    local dmgmod = 1


    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
