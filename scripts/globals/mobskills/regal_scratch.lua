---------------------------------------------------
-- Regal Scratch
-- M=3,1
---------------------------------------------------
require("scripts/globals/summon")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/magic")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local ele = tpz.damageType.LIGHT
    local dmgType = tpz.damageType.SLASHING
    local numhits = 3
    local accmod = -5
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, 1, 1, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, dmgType, info.hitslanded)

	if dmg > 0 and skill:getMsg() ~= 31 then
        target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, ele)
        target:tryInterruptSpell(mob, info.hitslanded)
    end
    return dmg
end
