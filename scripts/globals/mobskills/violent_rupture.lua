---------------------------------------------
--  Violent Rupture
--
--  Description: Deals high damage to players within an area of effect. Additional effect: Weight & knockback
--  Type: Breath
--  Utsusemi/Blink absorb: 2-3 shadows
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
    local numhits = 3
    local accmod = 1
    local dmgmod = 1.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    if info.hitslanded > 0 then
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.WEIGHT, 50, 0, 120)
    end
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.FIRE)
    return dmg
end
