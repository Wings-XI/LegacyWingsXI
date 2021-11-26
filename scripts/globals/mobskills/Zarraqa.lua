---------------------------------------------------
-- Ranged Attack
-- Deals a flaming ranged attack to a single target. Ignores Shadows
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
        return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.6

    local info = MobRangedMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)

    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.FIRE,  MOBPARAM_IGNORE_SHADOWS)

    if (dmg > 0) then
       target:addTP(20)
       mob:addTP(80)
    end

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.FIRE)
    return dmg
end
