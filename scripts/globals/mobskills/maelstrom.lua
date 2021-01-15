---------------------------------------------
--  Maelstrom
--
--  Description: Deals water damage to enemies within range. Additional effect: STR Down.
--  Type: Magical (Water)
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STR_DOWN
    MobStatusEffectMove(mob, target, typeEffect, 10, 3, 120)
    local bonus = 0
    local dmgmod = 1

    if mob:getID() == 17649731 then -- LoO
        bonus = -10
        --dmgmod = 0.99
    end
    
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.5, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT, 0, bonus)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end
