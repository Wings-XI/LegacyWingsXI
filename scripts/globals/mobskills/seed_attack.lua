---------------------------------------------
--  Seed Crystal's basic attack
--
--  Description: This is Seed Crystal's basic attack.
--  Type: Physical
--
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
    
    -- 70 59 6 68 31 0 5 21 0 0 0 42 0 0 2 0 0 546 1 3 49 55 3 1 0
    -- 29-90
    
    local info = MobPhysicalMove(mob, target, skill, 1, 2, 1, TP_NO_EFFECT, 1, 2, 3)
    local dmg = info.dmg * .5
    dmg = MobFinalAdjustments(dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.NONE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.NONE)
    skill:setMsg(tpz.msg.basic.HIT_DMG)

    --  local info = MobPhysicalMove(mob, target, skill, 1, 2, 1, TP_NO_EFFECT, 1, 2, 3)
    --   local dmg = info.dmg * .5
    --   dmg = MobFinalAdjustments(dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.NONE, MOBPARAM_IGNORE_SHADOWS, info.hitslanded)
    --    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.NONE)
    --   if info.hitslanded > 0 then
    --        skill:setMsg(tpz.msg.basic.HIT_DMG)
    --    end

    return dmg
end
