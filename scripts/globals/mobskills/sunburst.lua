---------------------------------------------
-- Sunburst
-- Delivers an attack that deals earth elemental damage.
-- Type: Magical
-- Range: Melee
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 4
    local dmgmod = 2
    local element = tpz.damageType.LIGHT
    if (math.random(1,2) == 2) then
        element = tpz.damageType.DARK
    end
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1.5, 2.0, 3.0)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, element, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, element)

	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end