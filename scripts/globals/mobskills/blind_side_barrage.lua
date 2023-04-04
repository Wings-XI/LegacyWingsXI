---------------------------------------------
--  Blind Side Barrage
--
--  Description: Damage varies with TP.
--  Type: Physical (Blunt)
--  Reduces STR and VIT
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        skill:setAoE(1)
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.STR_DOWN, 10, 0, 60)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.VIT_DOWN, 10, 0, 60)

    if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end

    return dmg
end
