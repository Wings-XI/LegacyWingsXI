---------------------------------------------
--  Body Slam
--
--  Description: Delivers an area attack. Damage varies with TP.
--  Type: Physical (Blunt)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local variation = TP_DMG_VARIES
    if mob:getID() == 17027473 then
        variation = TP_NO_EFFECT
        dmgmod = 1 + math.random(1, 2) * 0.25
    end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
