---------------------------------------------
--  Lightning Spear
--
--  Description: Wide Cone Attack lightning damage (600-1500) and powerful Amnesia.
--  Type: Magical
--  Notes: Will pick a random person on the hate list for this attack.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/utils")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 1 or mob:getLocalVar("charging") == 1 then
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
    local typeEffect = tpz.effect.AMNESIA
    local duration = math.random(30, 120)
    
   
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, duration)

    local dmgmod = 10 -- unbuffed player hit for ~2k

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.THUNDER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    return dmg
end

