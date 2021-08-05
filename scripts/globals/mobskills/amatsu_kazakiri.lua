---------------------------------------------
--  Amatsu: Kazakiri
--  Type: Physical
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 0 then -- if tenzen is in melee stance
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 2
    local accmod = 2
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 1.50, 2)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end