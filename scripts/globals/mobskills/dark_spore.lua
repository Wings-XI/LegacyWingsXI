---------------------------------------------
--  Dark Spore
--
--  Description: Unleashes a torrent of black spores in a fan-shaped area of effect, dealing dark damage to targets. Additional effect: Blind
--  Type: Magical Dark (Element)
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getPool() == 1281 then -- Fairy Ring (Dynamis-Valkurm)
        skill:setAoE(1)
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BLINDNESS
    local power = 800
    if mob:getPool() == 1281 then -- Fairy Ring (Dynamis-Valkurm)
        power = 1000
    end

    MobStatusEffectMove(mob, target, typeEffect, 15, 3, 120)

    local dmgmod = MobBreathMove(mob, target, 0.25, 2, tpz.magic.ele.DARK, power)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.DARK)
    return dmg
end
