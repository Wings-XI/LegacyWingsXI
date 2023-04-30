---------------------------------------------
--  Stormwind
--
--  Description: Creates a whirlwind that deals Wind damage to targets in an area of effect.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Unknown radial
--  Notes:
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1

    if mob:getName() == "Kreutzet" then
        local stormwindDamage = mob:getLocalVar("stormwindDamage")
        if stormwindDamage == 2 then
            dmgmod = 1.25
        elseif stormwindDamage == 3 then
            dmgmod = 1.6
        end
    end

    local bonusacc = 0
    if mob:getID() == 17228242 then -- simurgh
        bonusacc = 130
    end

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT, 0, bonusacc)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)

    if mob:getZone():getType() == tpz.zoneType.DYNAMIS then
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.SILENCE, 1, 0, math.random(60, 120))
    end
    return dmg
end
