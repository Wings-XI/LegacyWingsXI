---------------------------------------------
--  Gates of Hades
--
--  Description: Deals severe Fire damage to enemies within an area of effect. Additional effect: Burn
--  Type:  Magical
--
--
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 20' radial
--  Notes: Only used when a cerberus's health is 25% or lower (may not be the case for Orthrus). The burn effect takes off upwards of 20 HP per tick.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local result = 1
    local mobhp = mob:getHPP()

    if (mobhp <= 25) then
        if (mob:getID() == 17093004) and (mob:getInstance():getStage() ~= 100) then -- Nyzul Isle Cerberus will only use this on floor 100
            return 1
        end
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BURN
    local power = 21
    local dmgmod = 1.8

    if (mob:getID() == 17093004) then -- Nyzul Isle Cerberus https://youtu.be/e7CEeeRQ8qU?t=274
        power = 20
        dmgmod = 0.5
    elseif (mob:getID() == 17027485) then -- Sarameya
        power = 40
    end

    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*6, tpz.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    return dmg
end
