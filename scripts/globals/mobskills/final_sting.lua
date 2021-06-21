---------------------------------------------
--  Final Sting
--
--  Description: Deals damage proportional to HP. Reduces HP to 1 after use. Damage varies with TP.
--  Type: Physical (Piercing, Ranged)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1

    local mobHP = mob:getHP()
    local hpMod = skill:getMobHPP() / 100
    dmgmod = hpMod * (16 + math.random(2,6))

    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        dmgmod = dmgmod * 5
    end

    mob:setHP(0)
    
    if math.random()*100 < target:getGuardRate(mob) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        target:trySkillUp(mob, tpz.skill.GUARD, numhits)
        return 0
    end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
    if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
