---------------------------------------------
--  Tera Slash
--
--  Description: Deals high damage to players within a fan-shaped area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 2
    local dmgmod = 3

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 1.5, 2)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    if info.hitslanded > 0 and mob:getHPP() <= 25 and skill:getID() == 1135 then
        skill:setMsg(tpz.msg.basic.FALL_TO_GROUND)
        target:setHP(0) -- insta death
        return 0
    else
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
        if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
        return dmg
    end
end
