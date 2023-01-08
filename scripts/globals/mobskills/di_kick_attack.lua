---------------------------------------------
-- Unnamed attack for use to kick the target
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    -- don't autoattack between TP moves
    if mob:getLocalVar("timeSinceWS") > os.time() - 2 then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = .6

    local typeEffect = tpz.effect.WEIGHT
    local duration = math.random(3, 15)
    local power = 50

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = 0
    if info.hitslanded > 0 then
        dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    else
        skill:setMsg(tpz.msg.basic.EVADES)
        return
    end
	if skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB then
        if math.random(100) <= 75 then
            MobStatusEffectMove(mob, target, typeEffect, power, 0, duration)
        end
        target:tryInterruptSpell(mob, info.hitslanded)

        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
        skill:setMsg(tpz.msg.basic.HIT_DMG)
    end
    return dmg
end
