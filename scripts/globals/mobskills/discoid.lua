---------------------------------------------
-- Discoid
--  Note: according to wiki different mobs have different amounts of discoid dmg
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local needles = 10000 / skill:getTotalTargets()
    if (mob:getID() == 17092966) then
        -- Nyzul Isle Investigation Battledressed Chariot hits for 1k pre shell/etc
        needles = 1000 / skill:getTotalTargets()
    end
    local dmg = MobFinalAdjustments(needles, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)

    return dmg
end
