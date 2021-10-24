---------------------------------------------
--  Seed of Nihility
--
--  Description: Deals roughly 20% hp and resets all job abilities not currently on cooldown
--  Type: Magical
--
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- RESET JOB ABILITIES

    local dmgmod = 1
    local basedmg = target:getMaxHP() * math.random(18,25) * .01 -- 18%-25% damage base (higher range due to shell cutting dmg)
    local info = MobMagicalMove(mob, target, skill, basedmg, tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    return dmg
end
