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
function onMobSkillCheck(target, mob, skill)
    local param = skill:getParam()
    if param == 0 then param = 30 end
    
    if mob:getHPP() <= param then return 0 end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    
    dmgmod = 2 + skill:getMobHPP()/11

    if mob:isMobType(MOBTYPE_NOTORIOUS) then dmgmod = dmgmod + 3 end

    mob:setHP(0)
    
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
    if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
